import 'dart:io';

import 'package:exploration_planner/src/dashboard.dart';
import 'package:exploration_planner/src/editTicket.dart';
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 20, 255, 90))),
                      child: Text(
                        '22/22/2222',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 25,
                            color: Color.fromARGB(255, 255, 74, 2)),
                        textScaleFactor: 1.3,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 20, 255, 90))),
                      child: Text(
                        '22:22:22',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 255, 74, 2)),
                        textScaleFactor: 1.3,
                      ),
                    ),
                  ],
                ),
                Container(
                  child: IconButton(
                    icon: Icon(Icons.edit_note),
                    iconSize: 50,
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                        builder: (context) => EditTicket(controller.text),
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
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: 350,
              decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 21, 21, 22))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'WWWWWWWWWWw',
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
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.blueAccent)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'WWWWWWWWWWw',
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
              color: Colors.transparent,
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
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
