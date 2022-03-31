import 'dart:io';
import 'package:exploration_planner/src/validators.dart' as validators;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

final imgPicker = ImagePicker();
File? imageFile;
SharedPreferences? prefs;

Future<Image> photoFromCamera() async {
  var _pickedFile = await imgPicker.pickImage(source: ImageSource.camera);
  if (_pickedFile?.path != null) {
    imageFile = File(_pickedFile!.path);
    return Image.file(imageFile!, height: 450, width: 380);
  } else {
    return Image.asset('lib/assets/ticketRobot.png', height: 450, width: 380);
  }
}

Future<Image> photoFromGallery() async {
  var _pickedFile = await imgPicker.pickImage(source: ImageSource.gallery);
  if (_pickedFile?.path != null) {
    imageFile = File(_pickedFile!.path);
    return Image.file(imageFile!, height: 450, width: 380);
  } else {
    return Image.asset('lib/assets/ticketRobot.png', height: 450, width: 380);
  }
}

Future<bool> InsertListElement(BuildContext context, int lista) async {
  var nuevaCategoria = '';
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¿Como se llamará la nueva categoría?'),
          content: TextFormField(onChanged: (value) => nuevaCategoria = value),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Aceptar'),
              onPressed: () {
                nuevaCategoria = nuevaCategoria.trim();

                if (nuevaCategoria.length <= 10) {
                  if (nuevaCategoria != '') {
                    saveCategToPrefs(categ: nuevaCategoria, num: lista);

                    Navigator.pop(context);
                  } else {
                    print('No puede estar vacío o contener solo espacios');
                  }
                } else {
                  print('La longitud tiene que ser de 1 a 10');
                }
              },
            ),
          ],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        );
      });
  return true;
}

Future<bool> dialogRemoveReceipt(BuildContext context, String date) async {
  var accept = false;
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¿Seguro que quiere eliminar esta factura?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
                child: Text('Aceptar'),
                onPressed: () {
                  removeReceipt(date);
                  Navigator.pop(context);
                  accept = true;
                }),
          ],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        );
      });
  return accept;
}

Future<SharedPreferences?> getPrefs() async {
  prefs = await SharedPreferences.getInstance();
  var catsLoaded = prefs!.getBool('categsLoaded') ?? false;
  if (!catsLoaded) {
    await prefs!.setStringList('categList1', []);
    //await prefs!.setStringList('categList2', []);
    await prefs!.setBool('categsLoaded', true);
  }
  return prefs;
}

void saveCategToPrefs({required String categ, required int num}) {
  var nomLista = num == 1 ? 'categList1' : 'categList2';
  var listaCategs = prefs!.getStringList(nomLista);
  listaCategs!.add(categ);
  prefs!.setStringList(nomLista, listaCategs);
}

void saveFile(File? image, String categs) async {
  if (Platform.isAndroid && await _requestPermission(Permission.storage)) {
    var date = DateTime.now()
            .toString()
            .substring(0, 19)
            .replaceAll(RegExp(r' |:'), '-') +
        categs +
        '.jpg';
    var directory = await getExternalStorageDirectory();
    imageFile = await image!.copy(directory!.path + '/$date');
    await image.delete();
  }
}

/*Future <*/ List<File> /*>*/ getFiles() /*async*/ {
  if (Platform.isAndroid /*&& await _requestPermission(Permission.storage)*/) {
    var dir;
    var files = <File>[];
    getExternalStorageDirectory().then((value) {
      dir = value;
      for (var item in dir.listSync()) {
        files.add(item as File);
      }
    });
    return files;
  }
  return <File>[];
}

void removeReceipt(String date) {
  getExternalStorageDirectory().then((value) {
    var dir = value;
    for (var item in dir!.listSync()) {
      item = item as File;
      if (item.path.split('/').last.contains(date)) {
        item.delete();
      }
    }
  });
}

Future<bool> _requestPermission(Permission permission) async {
  if (await permission.isGranted) {
    return true;
  } else {
    var result = await permission.request();
    if (result == PermissionStatus.granted) {
      return true;
    }
  }
  return false;
}
