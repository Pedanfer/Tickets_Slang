import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final imgPicker = ImagePicker();
var _imagePath;

class DashBoard extends StatefulWidget {
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  var img = Image.asset('lib/assets/ticketRobot.png', scale: 11);
  var lista = ['casa', 'carro', 'vaca'];
  var lista2 = ['perro', 'motoro', 'choza'];
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
              DropdownButton(
                items: lista.map((String e){
                return DropdownMenuItem(
                  value: e,
                  child: Text(e));
                }).toList(),
                onChanged: (value) =>{
                  setState((){
                  vista = value.toString();
                  })
                }, hint: Text(vista)),

                  DropdownButton(
                items: lista2.map((String e){
                return DropdownMenuItem(
                  value: e,
                  child: Text(e));
                }).toList(),
                onChanged: (value) =>{
                  setState((){
                  vista2 = value.toString();
                  })
                }, hint: Text(vista2)),
              //Expanded(
                  //child: //Align(
                      //alignment: Alignment.bottomCenter,
                      /*child:*/ Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                          height: dimension.height * 0.08,
                          width: dimension.width * 0.40,
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
                                icon: Icon(Icons.camera),
                                onPressed: () {
                                  photoFromCamera()
                                      .then((value) => setState(() {
                                            img = value;
                                          }));
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.add_a_photo_sharp),
                                onPressed: () {
                                  photoFromGallery()
                                      .then((value) => setState(() {
                                            img = value;
                                          }));
                                },
                              )
                            ],
                          ))//))
            ],
          )),
          bottomNavigationBar: BottomNavigationBar(
            items: [
             BottomNavigationBarItem(icon: Icon(Icons.home), label: "HOME"),
             BottomNavigationBarItem(icon: Icon(Icons.plus_one), label:  "AÑADIR")
          ]),
    );
  }
}

Future<Image> photoFromCamera() async {
  XFile? _pickedFile = await imgPicker.pickImage(source: ImageSource.camera);
  return Image.file(File(_pickedFile!.path));
}

Future<Image> photoFromGallery() async {
  XFile? _pickedFile = await imgPicker.pickImage(source: ImageSource.gallery);
  return Image.file(File(_pickedFile!.path));
}
