import 'dart:io';

import 'package:exploration_planner/src/ticketlist.dart';
import 'package:exploration_planner/src/utilidades.dart';
import 'package:exploration_planner/src/widgets.dart';
import 'package:flutter/material.dart';

class EditTicket extends StatefulWidget {
  final String ruta;
  EditTicket(this.ruta);

  @override
  State<EditTicket> createState() => EditTicketState();
}

var categs = '';
String vista = 'Seleccione categoría';
bool isVisibleEditioCateg = false;

class EditTicketState extends State<EditTicket> {
  GlobalKey<DropDownCategsState> categsKey = GlobalKey();
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

    var filtrado1 = controller.text.split('.');
    var filtradocategs = filtrado1[3].split('|');
    var filtrado2 = filtrado1[2].split('/');
    var filtradotiempo = filtrado2[2].split('-');
    var categ1;
    var categ2;
    var fecha =
        filtradotiempo[2] + '/' + filtradotiempo[1] + '/' + filtradotiempo[0];
    var hora = filtradotiempo[3] + ':' + filtradotiempo[4];

    if (filtrado1[3].contains('|')) {
      categ1 = filtradocategs[0];
      categ2 = filtradocategs[1];
    } else {
      categ1 = '';
      categ2 = '';
    }

    if (categ1 == '') {
      categ1 = 'Vacio';
    }

    if (categ2 == '') {
      categ2 = 'Vacio';
    }
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
                            fecha,
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
                        hora,
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
                    color: !isVisibleEditioCateg
                        ? Colors.white
                        : Colors.transparent,
                    border: Border.all(
                      color: !isVisibleEditioCateg
                          ? Colors.white
                          : Colors.transparent,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        visible: isVisibleEditioCateg,
                        child: DropDownCategs(
                            (value) => categs += '.' + value.toString() + '|',
                            vista,
                            'categList1',
                            key: categsKey),
                      ),
                      Visibility(
                          visible: !isVisibleEditioCateg,
                          child: Text(
                            'CATEGORÍA 1: ' + categ1,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 0, 0, 0)),
                            textScaleFactor: 1.3,
                          )),
                      IconButton(
                        icon: !isVisibleEditioCateg
                            ? Icon(Icons.edit)
                            : Icon(Icons.save),
                        iconSize: 40,
                        color: Colors.black,
                        onPressed: () {
                          setState(() {
                            isVisibleEditioCateg = !isVisibleEditioCateg;
                          });
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
                  child: img,
                )
              ])),
    );
  }
}
