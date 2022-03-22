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
  int paginaActual = 1;
  var img = Image.asset('lib/assets/ticketRobot.png', scale: 11);
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
              //Expanded(
                  //child: //Align(
                      //alignment: Alignment.bottomCenter,
                      /*child:*/ Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                          height: dimension.height * 0.08,
                          width: dimension.width * 0.30,
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
