import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

final imgPicker = ImagePicker();
var imageFile;
SharedPreferences? prefs;

Future<Image> photoFromCamera() async {
  var _pickedFile = await imgPicker.pickImage(source: ImageSource.camera);
  imageFile = XFile(_pickedFile!.path);
  return Image.file(File(_pickedFile.path), height: 450, width: 380);
}

Future<Image> photoFromGallery() async {
  var _pickedFile = await imgPicker.pickImage(source: ImageSource.gallery);
  imageFile = XFile(_pickedFile!.path);
  return Image.file(File(_pickedFile.path), height: 450, width: 380);
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
                if (nuevaCategoria != '') {
                  saveCategToPrefs(categ: nuevaCategoria, num: lista);
                }
                Navigator.pop(context);
              },
            ),
          ],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        );
      });
  return true;
}

Future<SharedPreferences?> getPrefs() async {
  prefs = await SharedPreferences.getInstance();
  var catsLoaded = prefs!.getBool('categsLoaded') ?? false;
  if (!catsLoaded) {
    await prefs!.setStringList('categList1', []);
    await prefs!.setStringList('categList2', []);
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

void saveFile(XFile? image, String categs) async {
  if (Platform.isAndroid && await _requestPermission(Permission.storage)) {
    var date = DateTime.now()
            .toString()
            .substring(0, 16)
            .replaceAll(RegExp(r' |:'), '-') +
        categs +
        '.jpg';
    var directory = await getExternalStorageDirectory();
    await File(image!.path).copy(directory!.path + '/$date');
    await File(image.path).delete();
    setFile();
  }
}

/*Future <*/ List<File> /*>*/ setFile() /*async*/ {
  if (Platform.isAndroid /*&& await _requestPermission(Permission.storage)*/) {
    var dir = Directory(
        '/storage/emulated/0/Android/data/com.example.exploration_planner/files');
    if (dir.existsSync()) {
      var files = <File>[];
      for (var item in dir.listSync()) {
        files.add(item as File);
      }
        return files;
    }
  }
  return <File>[];
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
