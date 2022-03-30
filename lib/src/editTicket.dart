import 'dart:io';

import 'package:exploration_planner/src/utilidades.dart';
import 'package:flutter/material.dart';

class EditTicket extends StatefulWidget {
final String ruta;
EditTicket(this.ruta);

  @override
  State<EditTicket> createState() => EditTicketState();
}

class EditTicketState extends State<EditTicket> {
  TextEditingController controller = TextEditingController();
  var img;
  
@override
  void initState() {
    controller = TextEditingController(text: widget.ruta);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

     imageFile = File(controller.text);
    img = Image.file(imageFile!);

    return Scaffold(
      body: Container(
          padding: EdgeInsets.fromLTRB(20, 35, 20, 10),
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(255, 235, 235, 235),
                Color.fromARGB(255, 199, 230, 185),
              ],
            ),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          
                          child: IconButton(
                            icon: Icon(Icons.cancel),
                            iconSize: 40,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromARGB(255, 20, 255, 90))),
                          child: Text(
                            '22/22/2222',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 30,
                                color: Color.fromARGB(255, 255, 74, 2)),
                            textScaleFactor: 1.3,
                          ),
                        ),
                        Container(
                          child: IconButton(
                            icon: Icon(Icons.check),
                            iconSize: 40,
                            onPressed: () {
                                print('CONTROLLER: ' + controller.text);
                              // GUARDAR Y VOLVER
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 20, 255, 90))),
                      child: Text(
                        '22:22:22',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 255, 74, 2)),
                        textScaleFactor: 1.3,
                      ),
                    ),
                  ],
                )),



                Container(
                  
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: 350,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'CATEGORÍA 1: ' +
                            img.toString().substring(10, 20),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 85, 113, 136)),
                        textScaleFactor: 1.3,
                      ),
                      IconButton(
                        icon: Icon(Icons.edit_note),
                        iconSize: 40,
                        onPressed: () {
                          // Aparecer los botones de editar
                          // Aparecer el boton de aceptar
                          // Desaparecer este boton
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: 350,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'CATEGORÍA 2: ' +
                            img.toString().substring(20, 30),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 85, 113, 136)),
                        textScaleFactor: 1.3,
                      ),
                      IconButton(
                        icon: Icon(Icons.edit_note),
                        iconSize: 40,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Container( width: 350, height: 450,
                  color: Colors.red,
                  child: img,
                )
              ])),
    );
  }
}
