import 'dart:io';
import 'package:exploration_planner/src/editTicket.dart';
import 'package:exploration_planner/src/login_page.dart';
import 'package:exploration_planner/src/utilidades.dart';
import 'package:flutter/material.dart';

class TicketView extends StatefulWidget {
  final String ruta;
  TicketView(this.ruta);
  @override
  State<TicketView> createState() => TicketViewState();
}

Border border = Border.all();

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
                    SizedBox(height: dimension.height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: IconButton(
                            icon: Icon(Icons.share, color: Colors.white),
                            iconSize: 40,
                            onPressed: () {
                              createExcelFicha(controller.text).then((result) {
                                setState(() {
                                  /* LE DAMOS EL NUEVO VALOR QUE DEVOLVEMOS */
                                });
                              });
                            },
                          ),
                        ),
                        Container(
                          child: IconButton(
                            icon: Icon(Icons.edit_note, color: Colors.white),
                            iconSize: 50,
                            onPressed: () {
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
                    SizedBox(height: dimension.height * 0.02),
                    Container(
                      width: dimension.width * 0.9,
                      decoration: BoxDecoration(border: border),
                      child: Text(
                        fecha + '    ' + hora,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.white),
                        textScaleFactor: 1.3,
                      ),
                    ),
                  ],
                )),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: dimension.width * 0.9,
                  decoration: BoxDecoration(border: border),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        categ1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textScaleFactor: 1.3,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: dimension.width * 0.9,
                  decoration: BoxDecoration(border: border),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        categ2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textScaleFactor: 1.3,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: dimension.width * 0.9,
                  height: dimension.height * 0.55,
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
                ),
                Icon(Icons.pinch_rounded, size: 60)
              ])),
    );
  }
}
