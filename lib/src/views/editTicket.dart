import 'dart:io';

import 'package:exploration_planner/src/views/ticketlist.dart';
import 'package:exploration_planner/src/functions/utilidades.dart';
import 'package:exploration_planner/src/utils/widgets.dart';
import 'package:flutter/material.dart';

class EditTicket extends StatefulWidget {
  final Map<String, dynamic> ticketData;
  EditTicket(this.ticketData);
  @override
  State<EditTicket> createState() => EditTicketState();
}

var categs = '';
String vista = 'Seleccione categoría';
bool isVisibleEditioCateg = false;
bool isVisibleEditioCateg2 = false;

class EditTicketState extends State<EditTicket> {
  GlobalKey<DropDownCategsState> categsKey = GlobalKey();
  GlobalKey<DropDownCategsState> categsKey2 = GlobalKey();
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
                            TextStyle(fontSize: 30, color: Color(0xffECEEF3)),
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
                            'CATEGORÍA 1: ' + widget.ticketData['categ1'],
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: 350,
                  decoration: BoxDecoration(
                    color: !isVisibleEditioCateg2
                        ? Colors.white
                        : Colors.transparent,
                    border: Border.all(
                      color: !isVisibleEditioCateg2
                          ? Colors.white
                          : Colors.transparent,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        visible: isVisibleEditioCateg2,
                        child: DropDownCategs(
                            (value) => categs += '.' + value.toString() + '|',
                            vista,
                            'categList2',
                            key: categsKey2),
                      ),
                      Visibility(
                          visible: !isVisibleEditioCateg2,
                          child: Text(
                            'CATEGORÍA 2: ' + widget.ticketData['categ2'],
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 0, 0, 0)),
                            textScaleFactor: 1.3,
                          )),
                      IconButton(
                        icon: !isVisibleEditioCateg2
                            ? Icon(Icons.edit)
                            : Icon(Icons.save),
                        iconSize: 40,
                        color: Colors.black,
                        onPressed: () {
                          setState(() {
                            isVisibleEditioCateg2 = !isVisibleEditioCateg2;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 350,
                  height: 450,
                  child: Image.memory(widget.ticketData['photo']),
                )
              ])),
    );
  }
}
