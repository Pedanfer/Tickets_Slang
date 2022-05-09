import 'dart:async';
import 'dart:convert';
import 'package:slang_mobile/src/functions/communications.dart';
import 'package:slang_mobile/src/utils/widgets.dart';
import 'package:slang_mobile/src/views/loginpage.dart';
import 'package:flutter/material.dart';
import '../functions/communications.dart';
import '../functions/sqlite.dart';
import '../functions/utilidades.dart';
import 'package:slang_mobile/main.dart';
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
    'lib/assets/Slang/ticketRobot.png',
  );
  String categ1 = '';
  String categ2 = '';
  var ticket;
  var dropCategs2;

  @override
  void initState() {
    dropCategs2 = DropDownCategs(
        (value) => categ2 = value.toString(), vista2, [],
        key: categs2Key);
    super.initState();
  }

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
                    ? new AssetImage("lib/assets/backgrounds/fondo2.png")
                    : new AssetImage("lib/assets/backgrounds/fondo.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Opacity(
                  opacity: 0.95,
                  child: Container(
                    color: Color(0xFF41538280),
                    width: double.infinity,
                    height: 25,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text('\t\tTickets > ',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'IBM Plex Sans',
                                color: Colors.white)),
                        Text(
                          'Nuevo Ticket',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'IBM Plex Sans',
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, 30),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: dimension.height * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: 20),
                            Visibility(
                              visible: isVisibleImg,
                              maintainSize: false,
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
                                maintainSize: false,
                                child: IconButton(
                                  icon: Icon(Icons.cancel),
                                  iconSize: 20,
                                  onPressed: () {
                                    isVisibleImg = false;
                                    setState(() {
                                      img = Image.asset(
                                          'lib/assets/ticketRobot.png',
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
                          maintainSize: false,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                            child: Column(children: [
                              Container(
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Nombre:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff011A58))),
                                      Container(
                                        height: 32,
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
                              Divider(
                                color: Colors.black,
                                thickness: 1,
                              ),
                              Container(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Categoría:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff011A58))),
                                      Container(
                                        height: 32,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              DropDownCategs(
                                                  (value) =>
                                                      {auxDropDownDict(value)},
                                                  vista1,
                                                  json
                                                      .decode(prefs!
                                                          .getString('categs')!)
                                                      .keys
                                                      .toList(),
                                                  key: categs1Key),
                                            ]),
                                      ),
                                    ]),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                  padding: EdgeInsets.fromLTRB(77, 0, 0, 0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text('Subcategoría:',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xff011A58))),
                                        ),
                                        Container(
                                          height: 32,
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [dropCategs2]),
                                        ),
                                      ])),
                              Divider(
                                color: Colors.black,
                                thickness: 1,
                              ),
                            ]),
                          ),
                        ),
                        Visibility(
                          visible: isVisibleFotoGaleria,
                          maintainSize: false,
                          child: Container(
                            margin: EdgeInsets.only(
                                bottom: dimension.height * 0.15),
                            height: (dimension.height * 0.60) - 11,
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
                                        photoFrom('camera').then(
                                          (value) => setState(
                                            () {
                                              if (value) {
                                                img = Image.file(imageFile!,
                                                    height: 450, width: 380);
                                                isVisibleBorrarAceptar = true;
                                                isVisibleFotoGaleria = false;
                                                isVisibleCategorias = true;
                                                isVisibleImg = true;
                                              }
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                    Text('Hacer foto a ticket',
                                        style: TextStyle(color: Colors.white)),
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
                                          photoFrom('gallery').then((value) =>
                                              setState(() {
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
                          maintainSize: false,
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
                                  uploadImageToSlang(imageFile!)
                                      .then((value) => {
                                            jsonData = value,
                                            ticket = Ticket(
                                                issuer: jsonData['issuer'],
                                                date: jsonData['date']
                                                    .split('/')
                                                    .reversed
                                                    .join('-'),
                                                hour: jsonData['hour'],
                                                total: jsonData['total'] * 1.0,
                                                photo: imageFile!
                                                    .readAsBytesSync(),
                                                categ1: categ1,
                                                categ2: categ2),
                                            DB.insert(ticket)
                                          });
                                  img = Image.asset(
                                      'lib/assets/ticketRobot.png',
                                      scale: 1.5);
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        Future.delayed(Duration(seconds: 2),
                                            () {
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
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void auxDropDownDict(dynamic value) {
    setState(() {
      dropCategs2 = DropDownCategs((value) => categ2 = value.toString(), vista2,
          List<String>.from(json.decode(prefs!.getString('categs'))[value]),
          key: categs2Key);
    });
    categ1 = value.toString();
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
