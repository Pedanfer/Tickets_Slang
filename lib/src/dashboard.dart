import 'dart:ffi';
import 'dart:io';

import 'package:exploration_planner/src/ticketlist.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AddPage.dart';


var _imagePath;
SharedPreferences? prefs;

class DashBoard extends StatefulWidget {
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int paginaActual = 0;

  List<Widget> paginas = [
    AddPage(),
    Ticketlist(),
  ];

  @override
  Widget build(BuildContext context) {
    final dimension = MediaQuery.of(context).size;
    return Scaffold(
      body: paginas[paginaActual],
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
