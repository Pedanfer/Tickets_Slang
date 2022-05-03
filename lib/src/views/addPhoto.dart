import 'dart:async';

import 'package:exploration_planner/src/functions/communications.dart';
import 'package:exploration_planner/src/utils/constants.dart';
import 'package:exploration_planner/src/utils/widgets.dart';
import 'package:exploration_planner/src/views/login_page.dart';
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
  GlobalKey<DropDownCategsState> categs1Key = GlobalKey();
  GlobalKey<DropDownCategsState> categs2Key = GlobalKey();
  bool isVisibleBorrarAceptar = false;
  bool isVisibleFotoGaleria = true;
  bool isVisibleCategorias = false;
  bool isVisibleImg = false;
  String vista1 = 'Seleccionar categoría';
  String vista2 = 'Seleccionar categoría';
  var img = Image.asset(
    'lib/assets/ticketRobot.png',
  );
  var categ1 = '';
  var categ2 = '';
  var ticket;

  @override
  Widget build(BuildContext context) {
    final dimension = MediaQuery.of(context).size;
    return FutureBuilder(
        future: getPrefs(),
        builder: (context, snapshot) {
          return Scaffold(
              body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: isVisibleImg
                    ? new AssetImage("lib/assets/fondo2.png")
                    : new AssetImage("lib/assets/fondo.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Opacity(
                    opacity: 0.95,
                    child: Container(
                      width: double.infinity,
                      height: 30,
                      alignment: Alignment.centerLeft,
                      child: Text('\t\tTickets',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'IBM Plex Sans',
                              color: Colors.white)),
                      color: Color(0xFF41538280),
                    ),
                  ),
                  SizedBox(height: dimension.height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 20),
                      Visibility(
                        visible: isVisibleImg,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.blueAccent, width: 3)),
                          child: img,
                          width: dimension.width * 0.5,
                          height: dimension.height * 0.4,
                        ),
                      ),
                      Visibility(
                          visible: isVisibleBorrarAceptar,
                          child: IconButton(
                            icon: Icon(Icons.cancel),
                            iconSize: 20,
                            onPressed: () {
                              isVisibleImg = false;
                              setState(() {
                                img = Image.asset('lib/assets/ticketRobot.png',
                                    scale: 1.5);
                                isVisibleBorrarAceptar = false;
                                isVisibleFotoGaleria = true;
                                isVisibleCategorias = false;
                              });
                            },
                          )),
                    ],
                  ),
                  SizedBox(height: dimension.height * 0.02),
                  Visibility(
                    visible: isVisibleCategorias,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 5, 10,0),
                      child: Column(children: [
                        Container(
                          
                          child: Row(
                            
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Text('Nombre:', style:TextStyle(fontWeight: FontWeight.bold, color: Color(0xff011A58))),
                            Container(
                              height:32,
                              width: 315,
                              child: TextFormField(
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                  alignLabelWithHint: true,
                                  border: OutlineInputBorder(),
                                  hintText: '  Enter a search term',
                                ),
                              ),
                            )
                          ]),
                        ),
                         Divider(color: Colors.black,
                            thickness: 1,),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
 Text('Categoría:',  style:TextStyle(fontWeight: FontWeight.bold, color: Color(0xff011A58))),
                        Container(
                          height: 32,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DropDownCategs(
                                    (value) => categ1 = value.toString(),
                                    vista1,
                                    'categList1',
                                    key: categs1Key),
                                Row(children: [
                                  IconButton(
                                    icon: Icon(
                                        Icons.add_circle_outline_outlined,
                                        color: Color(0xff011A58)),
                                    iconSize: 20,
                                    onPressed: () {
                                      chooseCategNoBug(1);
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                        Icons.remove_circle_outline_outlined,
                                        color: Color(0xff011A58)),
                                    iconSize: 20,
                                    onPressed: () {
                                      deleteCateg(
                                              context, 1, categs1Key, dimension)
                                          .then((value) => setState(() {}));
                                      ;
                                    },
                                  ),
                                ])
                              ]),
                        ),
                        
                        ]),),
                       SizedBox(height: 8,),
                         Container(
                           padding: EdgeInsets.fromLTRB(77, 0, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [ Container(
                              child: Text('Subcategoría:', style:TextStyle(fontWeight: FontWeight.bold, color: Color(0xff011A58))),
                        ),Container(
                          
                          height: 32,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DropDownCategs(
                                    (value) => categ2 = value.toString(),
                                    vista2,
                                    'categList2',
                                    key: categs2Key),
                                Row(children: [
                                  IconButton(
                                    icon: Icon(
                                        Icons.add_circle_outline_outlined,
                                        color: Color(0xff011A58)),
                                    iconSize: 20,
                                    onPressed: () {
                                      chooseCategNoBug(2);
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                        Icons.remove_circle_outline_outlined,
                                        color: Color(0xff011A58)),
                                    iconSize: 20,
                                    onPressed: () {
                                      deleteCateg(
                                              context, 2, categs2Key, dimension)
                                          .then((value) => setState(() {}));
                                    },
                                  ),
                                ])
                              ]),
                        ),
                       ] )),
                       Divider(color: Colors.black,
                            thickness: 1,),
                        
                      ]),
                    ),
                  ),
                  Visibility(
                    visible: isVisibleFotoGaleria,
                    child: Container(
                      margin: EdgeInsets.only(bottom: dimension.height * 0.15),
                      height: dimension.height * 0.7,
                      width: dimension.width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: dimension.height * 0.2,
                            child: Column(children: [
                              IconButton(
                                icon: Icon(
                                  Icons.add_a_photo_outlined,
                                  color: Colors.white,
                                ),
                                iconSize: 56,
                                onPressed: () {
                                  photoFrom('camera')
                                      .then((value) => setState(() {
                                            if (value) {
                                              img = Image.file(imageFile!,
                                                  height: 450, width: 380);
                                              isVisibleBorrarAceptar = true;
                                              isVisibleFotoGaleria = false;
                                              isVisibleCategorias = true;
                                              isVisibleImg = true;
                                            }
                                          }));
                                },
                              ),
                              Text('Hacer foto a ticket',
                                  style: TextStyle(color: Colors.white))
                            ]),
                          ),
                          VerticalDivider(
                            color: Colors.white,
                            thickness: 2,
                          ),
                          Container(
                            height: dimension.height * 0.2,
                            child: Column(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.photo_library_outlined,
                                    color: Colors.white,
                                  ),
                                  iconSize: 56,
                                  onPressed: () {
                                    photoFrom('gallery')
                                        .then((value) => setState(() {
                                              if (value) {
                                                img = Image.file(imageFile!,
                                                    height: 450, width: 380);
                                                isVisibleBorrarAceptar = true;
                                                isVisibleFotoGaleria = false;
                                                isVisibleCategorias = true;
                                                isVisibleImg = true;
                                              }
                                            }));
                                  },
                                ),
                                Text(
                                  'Obtener ticket de \n galería',
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                      visible: isVisibleBorrarAceptar,
                      child: Container(
                        height: 40,
                        width: 190,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xFFDC47A9)),
                        child: TextButton(
                          child: Text(
                            'GUARDAR',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            isVisibleImg = false;
                            setState(() {
                              var jsonData;
                              //Controlar campos vacíos con 'Vacío'
                              uploadImageToSlang(imageFile!).then((value) => {
                                    jsonData = value,
                                    ticket = Ticket(
                                        issuer: jsonData['issuer'],
                                        date: jsonData['date']
                                            .split('/')
                                            .reversed
                                            .join('-'),
                                        hour: jsonData['hour'],
                                        total: jsonData['total'] * 1.0,
                                        photo: imageFile!.readAsBytesSync(),
                                        categ1: categ1,
                                        categ2: categ2),
                                    DB.insert(ticket)
                                  });
                              img = Image.asset('lib/assets/ticketRobot.png',
                                  scale: 1.5);
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    Future.delayed(Duration(seconds: 6), () {
                                      Navigator.pop(context, true);
                                    });
                                    return CustomAlertDialog(
                                        'Extrayendo datos...', dimension);
                                  });
                              isVisibleBorrarAceptar = false;
                              isVisibleFotoGaleria = true;
                              isVisibleCategorias = false;
                            });
                          },
                        ),
                      ))
                ],
              ),
            ),
          ));
        });
  }

  void chooseCategNoBug(int num) {
    setState(() {
      isVisibleBorrarAceptar = false;
      isVisibleCategorias = false;
      isVisibleImg = false;
    });
    insertNewCateg(context, num, dimension).then((value) => {
          Future.delayed(const Duration(milliseconds: 200), () {
            setState(() {
              isVisibleBorrarAceptar = true;
              isVisibleCategorias = true;
              isVisibleImg = true;
            });
          }),
        });
  }
}
