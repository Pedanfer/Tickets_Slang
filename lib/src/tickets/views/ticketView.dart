import 'package:slang_mobile/src/tickets/views/editTicket.dart';
import 'package:slang_mobile/src/tickets/views/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';

import '../functions/utilidades.dart';

class TicketView extends StatefulWidget {
  final Map<String, dynamic> ticketData;
  TicketView(this.ticketData);
  @override
  State<TicketView> createState() => TicketViewState();
}

Border border = Border.all(color: Colors.white);

class TicketViewState extends State<TicketView> {
  TransformationController controllerTransform = TransformationController();
  var initialControllerValue;

  @override
  Widget build(BuildContext context) {
    dimension = MediaQuery.of(context).size;
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
                              createExcelFicha(widget.ticketData)
                                  .then((result) async {
                                await FlutterShare.shareFile(
                                    title: 'Factura detallada',
                                    filePath:
                                        '/storage/emulated/0/Android/data/com.example.slang_mobile/files/Output.xlsx',
                                    text:
                                        'Comparto contigo este documento con la informacion del ticket');
                              });
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
                            icon: Icon(Icons.edit_note, color: Colors.white),
                            iconSize: 40,
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(
                                builder: (context) =>
                                    EditTicket(widget.ticketData),
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
                    SizedBox(height: dimension.height * 0.03),
                    Container(
                      width: dimension.width * 0.9,
                      decoration: BoxDecoration(border: border),
                      child: Text(
                        widget.ticketData['hour'],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, color: Colors.black),
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
                        widget.ticketData['categ1'],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, color: Colors.black),
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
                        widget.ticketData['categ2'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
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
                      child: Image.memory(
                        widget.ticketData['photo'],
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ),
                Icon(Icons.pinch_rounded, size: 45)
              ])),
    );
  }
}
