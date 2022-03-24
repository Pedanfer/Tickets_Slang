import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
final imgPicker = ImagePicker();

var _imagePath;
SharedPreferences? prefs;

class AddPhoto extends StatefulWidget {
  @override
  State<AddPhoto> createState() => AddPhotoState();
}

class AddPhotoState extends State<AddPhoto> {
  @override
  Widget build(BuildContext context) {
    final dimension = MediaQuery.of(context).size;
    bool isVisibleBorrarAceptar = false;
    bool isVisibleFotoGaleria = true;
    bool isVisibleCategorias = false;

    var img = Image.asset('lib/assets/ticketRobot.png', scale: 11);
    String vista = 'Seleccione categoría';
    String vista2 = 'Seleccione categoría';
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
                Color.fromARGB(255, 178, 204, 226),
                Color.fromARGB(255, 112, 221, 145),
              ],
            )),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              width: double.infinity - 20,
              height: double.infinity - 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  img,
                  Visibility(
                    visible: isVisibleCategorias,
                    child: Container(
                      color: Colors.red,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(children: [
                        Container(
                          color: Colors.yellow,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 2.5),
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(color: Colors.black)),
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
                                      setState(() {
                                        vista = value.toString();
                                      })
                                    },
                                    hint: Text(
                                      vista,
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 74, 168, 245),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: IconButton(
                                    icon: Icon(Icons.add_box),
                                    iconSize: 40,
                                    onPressed: () {
                                      setState(() {
                                        InsertListElement(context, 1);
                                        isVisibleBorrarAceptar = true;
                                      });
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
                                  ),
                                  child: DropdownButton(
                                      items: prefs!
                                          .getStringList('categList2')!
                                          .map((String e) {
                                        return DropdownMenuItem(
                                            value: e, child: Text(e));
                                      }).toList(),
                                      onChanged: (value) => {
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
                                      setState(() {
                                        isVisibleBorrarAceptar = false;
                                        //InsertListElement(context, 2);
                                      });
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
                      height: dimension.height * 0.08,
                      width: dimension.width * 0.32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color.fromARGB(220, 161, 3, 64),
                            Color.fromARGB(255, 238, 234, 7),
                          ],
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(Icons.add_a_photo_sharp),
                            onPressed: () {setState(() {
                              photoFromCamera().then((value) => setState(() {
                                    img = value;
                                    isVisibleBorrarAceptar = true;
                                    isVisibleFotoGaleria = false;
                                    isVisibleCategorias = true;
                                  }));
                            });
                            },
                          ),
                          Text(' | '),
                          IconButton(
                            icon: Icon(Icons.image),
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
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color.fromARGB(220, 16, 219, 169),
                              Color.fromARGB(255, 255, 0, 179),
                            ],
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              child: Text('BORRAR'),
                              onPressed: () {
                                setState(() {
                                  img = Image.asset(
                                      'lib/assets/ticketRobot.png',
                                      scale: 11);
                                  isVisibleBorrarAceptar = false;
                                  isVisibleFotoGaleria = true;
                                  isVisibleCategorias = false;
                                });
                              },
                            ),
                            TextButton(
                              child: Text('ENVIAR'),
                              onPressed: () {
                                setState(() {
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
  return Image.file(File(_pickedFile!.path), height: 500, width: 380);
}

Future<Image> photoFromGallery() async {
  var _pickedFile = await imgPicker.pickImage(source: ImageSource.gallery);
  return Image.file(File(_pickedFile!.path));
}

void InsertListElement(BuildContext context, int lista) {
  var nuevaCategoria = '';
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¿Como se llamará el nuevo elemento?'),
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
                print("llega");
                Navigator.pop(context);
              },
            ),
          ],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        );
      });
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

void saveFile(XFile? image) async {
  if (await _requestPermission(Permission.storage) &&
      await _requestPermission(Permission.manageExternalStorage)) {
    Directory? directory;
    var date = DateTime.now()
        .toString()
        .substring(0, 16)
        .replaceAll(RegExp(r' |:'), '-') + '.jpg';
    var fileName = date;
    try {
      if (Platform.isAndroid) {
        directory = await getExternalStorageDirectory();
        var newPath = '';
        var paths = directory!.path.split('/');
        for (var x = 1; x < paths.length; x++) {
          var folder = paths[x];
          if (folder != 'Android') {
            newPath += '/' + folder;
          } else {
            break;
          }
        }
        newPath = newPath + '/Slang Ticket Manager';
        directory = Directory(newPath);
      } else if (await _requestPermission(Permission.photos)) {
        directory = await getTemporaryDirectory();
      }

      if (!await directory!.exists()) {
        await directory.create(recursive: true);
      }

      if (Platform.isAndroid) {
        await File(image!.path).copy(directory.path + '/$fileName');
        await File(image.path).delete();
      } else {
        await ImageGallerySaver.saveFile(directory.path + '/$fileName',
            isReturnPathOfIOS: true);
      }
    } catch (e) {
      print(e);
    }
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