import 'package:exploration_planner/src/functions/utilidades.dart';
import 'package:flutter/material.dart';

class EditTicket extends StatefulWidget {
  final Map<String, dynamic> ticketData;
  EditTicket(this.ticketData);
  @override
  State<EditTicket> createState() => EditTicketState();
}

class EditTicketState extends State<EditTicket> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                Color(0xff011A58),
                Color(0xffECEEF3),
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
                            icon: Icon(Icons.cancel, color: Colors.white),
                            iconSize: 40,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        Container(
                          child: Text(
                            widget.ticketData['date'],
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 30, color: Color(0xffECEEF3)),
                            textScaleFactor: 1.3,
                          ),
                        ),
                        Container(
                          child: IconButton(
                            icon: Icon(Icons.check, color: Colors.white),
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
                      child: Text(
                        widget.ticketData['hour'],
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 15, color: Color(0xffECEEF3)),
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
                        'CATEGORÍA 1: ' + widget.ticketData['categ'],
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 15, color: Colors.white),
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
                /*
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: 350,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'CATEGORÍA 2: ' + categ2,
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
                ),*/
                Container(
                  width: 350,
                  height: 450,
                  child: Image.file(imageFile!),
                )
              ])),
    );
  }
}
