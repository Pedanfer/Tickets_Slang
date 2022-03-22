import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Image? img;
final imgPicker = ImagePicker();
var _imagePath;

class DashBoard extends StatefulWidget {
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int paginaActual = 1;

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
          child: img),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          photoFromCamera().then((value) => setState(() {
                img = value;
              }));
          paginaActual = index;
        },
        currentIndex: paginaActual,
        backgroundColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_camera_back),
            label: 'Galería',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_a_photo_sharp), label: 'Tomar Foto')
        ],
      ),
    );
  }
}

Future<Image> photoFromCamera() async {
  XFile? _pickedFile = await imgPicker.pickImage(source: ImageSource.camera);
  return Image.file(File(_pickedFile!.path), width: 300, height: 100);
}

Future<Image> photoFromGallery() async {
  XFile? _pickedFile = await imgPicker.pickImage(source: ImageSource.gallery);
  return Image.file(File(_pickedFile!.path), width: 300, height: 100);
}
