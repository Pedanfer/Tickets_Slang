import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final imgPicker = ImagePicker();
var _imagePath;
SharedPreferences? prefs;

class DashBoard extends StatefulWidget {
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int paginaActual = 0;
  var img = Image.asset('lib/assets/ticketRobot.png', scale: 11);
  var lista = ['casa', 'carro', 'vaca', '--Nuevo--'];
  var lista2 = ['perro', 'motoro', 'mastoideo', '--Nuevo--'];
  String vista = 'Seleccione una opcion';
  String vista2 = 'Seleccione una opcion';

  @override
  Widget build(BuildContext context) {
    final dimension = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              img,
              Container(
                margin:EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    
                      children: [
                    Container(
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
                                  iconSize: 40,
                                  icon: Icon(Icons.arrow_drop_down,
                                      color: Colors.black),
                                  items: lista.map((String e) {
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
                                        fontSize: 15,
                                        color:
                                            Color.fromARGB(255, 74, 168, 245)),
                                  ))),
                          Container(
                            child: IconButton(
                              icon: Icon(Icons.add_link_sharp),
                              onPressed: () {
                                photoFromCamera().then((value) => setState(() {
                                      img = value;
                                    }));
                              },
                            ),
                          )
                        ])),
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
                                items: lista2.map((String e) {
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
                              icon: Icon(Icons.add_a_photo_sharp),
                              onPressed: () {
                                photoFromCamera().then((value) => setState(() {
                                      img = value;
                                    }));
                              },
                            ),
                          )
                        ]))
                  ])),

              Container(
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
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.add_a_photo_sharp),
                        onPressed: () {
                          photoFromCamera().then((value) => setState(() {
                                img = value;
                              }));
                        },
                      ),
                      Text(' | '),
                      IconButton(
                        icon: Icon(Icons.image),
                        onPressed: () {
                          photoFromGallery().then((value) => setState(() {
                                img = value;
                              }));
                        },
                      )
                    ],
                  )) //))
            ],
          )),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 179, 185, 178),
        onTap: (index) {
          setState(() {
            paginaActual = index;
          });
        },
        currentIndex: paginaActual,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "AÑADIR"),
          BottomNavigationBarItem(
              icon: Icon(Icons.folder_open_outlined), label: "CATEGORIAS")
        ],
        showUnselectedLabels: false,
      ),
    );
  }
}

Future<Image> photoFromCamera() async {
  XFile? _pickedFile = await imgPicker.pickImage(source: ImageSource.camera);
  return Image.file(File(_pickedFile!.path), height: 500, width: 380);
}

Future<Image> photoFromGallery() async {
  XFile? _pickedFile = await imgPicker.pickImage(source: ImageSource.gallery);
  return Image.file(File(_pickedFile!.path));
}

void getPrefs() async {
  await SharedPreferences.getInstance().then((value) => prefs = value);
}

void saveCategToPrefs({required String categ}) {
  getPrefs();
  var listCategs = prefs?.getStringList('listaCategs');
  if (listCategs != null) listCategs.add(categ);
}
