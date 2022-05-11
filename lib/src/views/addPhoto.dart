import 'dart:async';
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:slang_mobile/main.dart';
import '../functions/communications.dart';
import '../functions/sqlite.dart';
import '../functions/utilidades.dart';

import '../utils/ticket.dart';
import '../utils/widgets.dart';

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
  var categ1 = '';
  String subCateg = '';
  var ticket;
  var subCategs;
  var ticketName = '';

  @override
  void initState() {
    subCategs = DropDownCategs(
        (value) => subCateg = value.toString(), vista2, [],
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
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                                  color: Color(0xFF011A58), width: 3)),
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
                                    'lib/assets/Slang/ticketRobot.png',
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: dimension.height * 0.0227,
                                  width: dimension.width * 0.15,
                                  child: Text(
                                    'Nombre:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff011A58),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: dimension.height * 0.03456,
                                  width: dimension.width * 0.75,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(
                                          dimension.width * 0.028, 0, 0, 0),
                                      alignLabelWithHint: true,
                                      border: OutlineInputBorder(),
                                      hintText: 'Introduce un nombre',
                                    ),
                                    onChanged: (value) =>
                                        ticketName = value.toString(),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                        Expanded(
                                          child: Container(
                                            child: DropDownCategs(
                                                (value) =>
                                                    {auxDropDownDict(value)},
                                                vista1,
                                                json
                                                    .decode(prefs!
                                                        .getString('categs')!)
                                                    .keys
                                                    .toList(),
                                                key: categs1Key),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                              Icons.add_circle_outline_outlined,
                                              color: Color(0xff011A58)),
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            //chooseCategNoBug(1);
                                          },
                                        ),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Container(child: subCategs),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                                Icons
                                                    .add_circle_outline_outlined,
                                                color: Color(0xff011A58)),
                                            padding: EdgeInsets.zero,
                                            onPressed: () {
                                              //chooseCategNoBug(1);
                                            },
                                          ),
                                        ]),
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
                          top: dimension.height * 0.13,
                          bottom: dimension.height * 0.15),
                      height: (dimension.height * 0.44 - .15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: (dimension.height * 0.44 - .15),
                                    width: dimension.width * 0.45,
                                    child: IconButton(
                                      icon: SvgPicture.asset(
                                          'lib/assets/icons/Camara.svg'),
                                      onPressed: () {
                                        photoFrom('camera')
                                            .then((value) => setState(() {
                                                  if (value) {
                                                    img = Image.file(imageFile!,
                                                        height: 450,
                                                        width: 380);
                                                    isVisibleBorrarAceptar =
                                                        true;
                                                    isVisibleFotoGaleria =
                                                        false;
                                                    isVisibleCategorias = true;
                                                    isVisibleImg = true;
                                                  }
                                                }));
                                      },
                                    ),
                                  ),
                                ]),
                          ),
                          VerticalDivider(
                            width: dimension.width * 0.05,
                            color: Colors.white,
                            thickness: 2,
                          ),
                          Container(
                            height: (dimension.height * 0.44 - .15),
                            width: dimension.width * 0.45,
                            child: IconButton(
                              icon: SvgPicture.asset(
                                  'lib/assets/icons/Galeria.svg'),
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
                            isVisibleBorrarAceptar = false;
                            isVisibleFotoGaleria = true;
                            isVisibleCategorias = false;
                            customSnackBar(context, 'Enviando la imagen...', 4);
                          });
                          var jsonData;
                          //Controlar campos vacíos con 'Vacío'
                          uploadImageToSlang(imageFile!).then(
                            (value) => {
                              jsonData = value,
                              if (!jsonData
                                  .toString()
                                  .contains('error - textract'))
                                {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        Future.delayed(Duration(seconds: 4),
                                            () {
                                          Navigator.pop(context, true);
                                          customSnackBar(
                                              context,
                                              'Ticket introducido en la base de datos.',
                                              3);
                                        });
                                        return CustomAlertDialog(
                                            'Extrayendo datos...', dimension);
                                      }),
                                  ticket = Ticket(
                                      issuer: jsonData['issuer'],
                                      ticketName: ticketName,
                                      date: jsonData['date']
                                          .split('/')
                                          .reversed
                                          .join('-'),
                                      hour: jsonData['hour'],
                                      total: jsonData['total'] * 1.0,
                                      photo: imageFile!.readAsBytesSync(),
                                      categ1: categ1,
                                      categ2: subCateg),
                                  DB.insert(ticket),
                                }
                              else
                                {
                                  customSnackBar(
                                      context,
                                      'No se han podido extraer datos, ¿seguro que es un ticket?',
                                      4)
                                },
                            },
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void auxDropDownDict(dynamic value) {
    setState(() {
      subCategs = DropDownCategs((value) => subCateg = value.toString(), vista2,
          List<String>.from(json.decode(prefs!.getString('categs')!)[value]),
          key: categs2Key);
    });
    categ1 = value.toString();
  }
}
