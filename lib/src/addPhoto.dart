import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

final imgPicker = ImagePicker();
var imageFile;
SharedPreferences? prefs;

class AddPhoto extends StatefulWidget {
  @override
  State<AddPhoto> createState() => AddPhotoState();
}

class AddPhotoState extends State<AddPhoto> {
  var categs = '';
  bool isVisibleBorrarAceptar = false;
  bool isVisibleFotoGaleria = true;
  bool isVisibleCategorias = false;
  String vista = 'Seleccione categoría';
  String vista2 = 'Seleccione categoría';
  var img = Image.asset(
    'lib/assets/ticketRobot.png',
  );

  @override
  Widget build(BuildContext context) {
    final dimension = MediaQuery.of(context).size;
    return FutureBuilder(
        future: getPrefs(),
        builder: (context, snapshot) {
          return Container(
            
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xff011A58),
                Color(0xffECEEF3),
              ],
            )),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              width: double.infinity - 20,
              height: double.infinity - 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child
                    :img
                  ),
                  
                  Visibility(
                    visible: isVisibleCategorias,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(children: [
                        Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 2.5),
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(color: Colors.black),
                                      color: Colors.white),
                                  child: DropdownButton(
                                    icon: Icon(Icons.arrow_drop_down,
                                        color: Colors.black),
                                    items: prefs!
                                        .getStringList('categList1')!
                                        .map((String e) {
                                      return DropdownMenuItem(
                                          value: e, child: Text(e));
                                    }).toList(),
                                    onChanged: (value) => {
                                      categs += value.toString() + '|',
                                      setState(() {
                                        vista = value.toString();
                                      })
                                    },
                                    hint: Text(
                                      vista,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: IconButton(
                                    icon: Icon(Icons.add_box),
                                    iconSize: 40,
                                    onPressed: () {
                                      InsertListElement(context, 1)
                                          .then((value) => setState(() {}));
                                    },
                                  ),
                                )
                              ]),
                        ),
                        Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 2.5),
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(color: Colors.black),
                                      color: Colors.white),
                                  child: DropdownButton(
                                      items: prefs!
                                          .getStringList('categList2')!
                                          .map((String e) {
                                        return DropdownMenuItem(
                                            value: e, child: Text(e));
                                      }).toList(),
                                      onChanged: (value) => {
                                            categs += value.toString(),
                                            setState(() {
                                              vista2 = value.toString();
                                            })
                                          },
                                      hint: Text(vista2)),
                                ),
                                Container(
                                  child: IconButton(
                                    icon: Icon(Icons.add_box),
                                    iconSize: 40,
                                    onPressed: () {
                                      InsertListElement(context, 2)
                                          .then((value) => setState(() {}));
                                    },
                                  ),
                                )
                              ]),
                        )
                      ]),
                    ),
                  ),
                  Visibility(
                    visible: isVisibleFotoGaleria,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      height: dimension.height * 0.09,
                      width: dimension.width * 0.38,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xffD0098D)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.add_a_photo_sharp,
                              color: Colors.white,
                            ),
                            iconSize: 42,
                            onPressed: () {
                              print(isVisibleBorrarAceptar);
                              photoFromCamera().then((value) => setState(() {
                                    img = value;
                                    isVisibleBorrarAceptar = true;
                                    isVisibleFotoGaleria = false;
                                    isVisibleCategorias = true;
                                  }));
                              print(isVisibleBorrarAceptar);
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.image,
                              color: Colors.white,
                            ),
                            iconSize: 42,
                            onPressed: () {
                              photoFromGallery().then((value) => setState(() {
                                    img = value;
                                    isVisibleBorrarAceptar = true;
                                    isVisibleFotoGaleria = false;
                                    isVisibleCategorias = true;
                                  }));
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                      visible: isVisibleBorrarAceptar,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff415382),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              child: Text('BORRAR'),
                              onPressed: () {
                                setState(() {
                                  img =
                                      Image.asset('lib/assets/ticketRobot.png');
                                  isVisibleBorrarAceptar = false;
                                  isVisibleFotoGaleria = true;
                                  isVisibleCategorias = false;
                                });
                              },
                            ),
                            TextButton(
                              child: Text('ENVIAR'),
                              onPressed: () {
                                saveFile(imageFile, categs);
                                setState(() {
                                  img =
                                      Image.asset('lib/assets/ticketRobot.png');
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Text(
                                              'El ticket se ha añadido correctamente'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text('OK'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                        );
                                      });
                                  isVisibleBorrarAceptar = false;
                                  isVisibleFotoGaleria = true;
                                  isVisibleCategorias = false;
                                });
                              },
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          );
        });
  }
}

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
  }
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
