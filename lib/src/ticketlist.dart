import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Ticketlist extends StatefulWidget {
  @override
  State<Ticketlist> createState() => TicketlistState();
}

class TicketlistState extends State<Ticketlist> {
  int paginaActual = 0;
  bool isVisibleBorrarAceptar = false;
  bool isVisibleFotoGaleria = true;
  bool isVisibleCategorias = false;

  var img = Image.asset('lib/assets/ticketRobot.png', scale: 11);
  String vista = 'Seleccione categoría';
  String vista2 = 'Seleccione categoría';

  @override
  Widget build(BuildContext context) {
    final dimension = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 2, 137, 248),
            Color.fromARGB(255, 0, 15, 5),
          ],
        ),
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Lista')
          ]),

/*
      child: Scrollbar(
        isAlwaysShown: true,
        showTrackOnHover: true,
        child: ListView.builder(itemBuilder: (c, i) => MyItem(i), itemCount: 20,),)*/


    );
  }
}
