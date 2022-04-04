import 'dart:async';

import 'package:exploration_planner/src/functions/communications.dart';
import 'package:exploration_planner/src/utils/widgets.dart';
import 'package:flutter/material.dart';
import '../functions/communications.dart';
import '../functions/sqlite.dart';
import '../functions/utilidades.dart';
import '../utils/ticket.dart';

class AddPhoto extends StatefulWidget {
  @override
  State<AddPhoto> createState() => AddPhotoState();
}

class AddPhotoState extends State<AddPhoto> {
  GlobalKey<DropDownCategsState> categsKey = GlobalKey();
  bool isVisibleBorrarAceptar = false;
  bool isVisibleFotoGaleria = true;
  bool isVisibleCategorias = false;
  String vista = 'Seleccione categoría';
  //String vista2 = 'Seleccione categoría';
  var img = Image.asset(
    'lib/assets/ticketRobot.png',
  );
  var categs = '';
  var ticket;

  @override
  Widget build(BuildContext context) {
    final dimension = MediaQuery.of(context).size;
    return FutureBuilder(
        future: getPrefs(),
        builder: (context, snapshot) {
          return Container(
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
            )),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              width: double.infinity - 20,
              height: double.infinity - 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: dimension.height * 0.05),
                  img,
                  SizedBox(height: dimension.height * 0.015),
                  Visibility(
                    visible: isVisibleCategorias,
                    child: Column(children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DropDownCategs(
                                (value) =>
                                    categs += '.' + value.toString() + '|',
                                vista,
                                'categList1',
                                key: categsKey),
                            Container(
                              child: IconButton(
                                icon: Icon(Icons.add_box,
                                    color: Color(0xff011A58)),
                                iconSize: 40,
                                onPressed: () {
                                  setState(() {
                                    isVisibleBorrarAceptar = false;
                                    isVisibleCategorias = false;
                                  });
                                  InsertListElement(context, 1).then((value) =>
                                      {
                                        setState(() {}),
                                        Future.delayed(
                                            const Duration(milliseconds: 150),
                                            () {
                                          setState(() {
                                            isVisibleBorrarAceptar = true;
                                            isVisibleCategorias = true;
                                          });
                                        }),
                                      });
                                },
                              ),
                            )
                          ]),
                      /*Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DropDownCategs(
                                    (value) => categs += value.toString(),
                                    vista2,
                                    'categList2'),
                                Container(
                                  child: IconButton(
                                    icon: Icon(Icons.add_box),
                                    iconSize: 40,
                                    onPressed: () {
                                      InsertListElement(context, 2)
                                          .then((value) => setState(() {}));
                                    },
                                  ),
                                )
                              ]),
                        )*/
                    ]),
                  ),
                  Visibility(
                    visible: isVisibleFotoGaleria,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      height: dimension.height * 0.09,
                      width: dimension.width * 0.38,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xffD0098D)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.add_a_photo_sharp,
                              color: Colors.white,
                            ),
                            iconSize: 42,
                            onPressed: () {
                              photoFromCamera().then((value) => setState(() {
                                    if (value.toString() !=
                                        Image.asset(
                                                'lib/assets/ticketRobot.png',
                                                height: 450,
                                                width: 380)
                                            .toString()) {
                                      img = value;
                                      isVisibleBorrarAceptar = true;
                                      isVisibleFotoGaleria = false;
                                      isVisibleCategorias = true;
                                    }
                                  }));
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.image,
                              color: Colors.white,
                            ),
                            iconSize: 42,
                            onPressed: () {
                              photoFromGallery().then((value) => setState(() {
                                    if (value.toString() !=
                                        Image.asset(
                                                'lib/assets/ticketRobot.png',
                                                height: 450,
                                                width: 380)
                                            .toString()) {
                                      img = value;
                                      isVisibleBorrarAceptar = true;
                                      isVisibleFotoGaleria = false;
                                      isVisibleCategorias = true;
                                    }
                                  }));
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                      visible: isVisibleBorrarAceptar,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff415382),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              child: Text(
                                'BORRAR',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                setState(() {
                                  img =
                                      Image.asset('lib/assets/ticketRobot.png');
                                  isVisibleBorrarAceptar = false;
                                  isVisibleFotoGaleria = true;
                                  isVisibleCategorias = false;
                                });
                              },
                            ),
                            TextButton(
                              child: Text(
                                'ENVIAR',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                setState(() {
                                  ticket = Ticket(
                                      issuer: 'Prueba',
                                      date: imageFile!
                                          .toString()
                                          .substring(78, 88),
                                      total: 9999,
                                      photo: imageFile!.readAsBytesSync(),
                                      categ: categs);
                                  DB.insert(ticket);
                                  uploadImageToSlang(categs, imageFile!);
                                  img =
                                      Image.asset('lib/assets/ticketRobot.png');
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Text(
                                              'El ticket se ha añadido correctamente'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text('OK'),
                                              onPressed: () {
                                                if (categs.contains('|') ==
                                                    false) {
                                                  categs = '.|' + categs;
                                                }
                                                saveFile(imageFile, categs);
                                                categs = '';
                                                Navigator.pop(context, true);
                                              },
                                            ),
                                          ],
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                        );
                                      });
                                  isVisibleBorrarAceptar = false;
                                  isVisibleFotoGaleria = true;
                                  isVisibleCategorias = false;
                                });
                              },
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          );
        });
  }
}
