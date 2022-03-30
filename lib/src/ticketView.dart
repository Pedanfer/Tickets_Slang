import 'dart:io';

import 'package:exploration_planner/src/dashboard.dart';
import 'package:exploration_planner/src/editTicket.dart';
import 'package:exploration_planner/src/ticketlist.dart';
import 'package:exploration_planner/src/utilidades.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TicketView extends StatefulWidget {
  final String ruta;
  TicketView(this.ruta);
  @override
  State<TicketView> createState() => TicketViewState();
}

class TicketViewState extends State<TicketView> {
  TransformationController controllerTransform = TransformationController();
  var initialControllerValue;
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
          padding: EdgeInsets.fromLTRB(20, 25, 20, 10),
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(255, 255, 0, 128),
                Color.fromARGB(255, 72, 221, 2),
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
                            icon: Icon(Icons.arrow_back_ios),
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
                            fecha,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 30,
                                color: Color.fromARGB(255, 255, 74, 2)),
                            textScaleFactor: 1.3,
                          ),
                        ),
                        Container(
                          child: IconButton(
                            icon: Icon(Icons.edit_note),
                            iconSize: 50,
                            onPressed: () {
                              print(img.toString());
                              Navigator.of(context)
                                  .push(MaterialPageRoute(
                                builder: (context) =>
                                    EditTicket(controller.text),
                              ))
                                  .then((result) {
                                if (result != null) {
                                  setState(() {
                                    /* LE DAMOS EL NUEVO VALOR QUE DEVOLVEMOS */
                                  });
                                }
                              });
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
                        hora,
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
                      border:
                          Border.all(color: Color.fromARGB(255, 21, 21, 22))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        categ1,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.shadowsIntoLight(
                          fontSize: 20,
                        ),
                        textScaleFactor: 1.3,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        categ2,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.shadowsIntoLight(
                          fontSize: 20,
                        ),
                        textScaleFactor: 1.3,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 350,
                  height: 450,
                  color: Colors.red,
                  child: InteractiveViewer(
                clipBehavior: Clip.hardEdge,
                panEnabled: false,
                minScale: 1,
                maxScale: 6,
                transformationController: controllerTransform,
                onInteractionStart: (details) {
                  initialControllerValue = controllerTransform.value;
                },
                onInteractionEnd: (details) {
                  controllerTransform.value = initialControllerValue;
                },
                child: ClipRRect(
                  child: Image.file(
                    imageFile!,
                    fit: BoxFit.scaleDown, 
                  ),
                ),
              ),
                )
              ])),
    );
  }
}
