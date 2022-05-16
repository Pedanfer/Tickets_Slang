import 'dart:convert';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:slang_mobile/main.dart';
import 'package:slang_mobile/src/utils/constants.dart';
import 'package:slang_mobile/src/views/addPhoto.dart';
import 'package:slang_mobile/src/views/dashboard.dart';
import 'package:slang_mobile/src/views/menu.dart';
import 'package:slang_mobile/src/views/ticketlist.dart';
import '../functions/sqlite.dart';
import '../functions/utilidades.dart';
import '../utils/widgets.dart';

class TicketView extends StatefulWidget {
  final Map<String, dynamic> ticketData;
  TicketView(this.ticketData);
  @override
  State<TicketView> createState() => TicketViewState();
}

Border border = Border.all(color: Colors.white);

class TicketViewState extends State<TicketView> {
  GlobalKey<DropDownCategsState> categs1Key = GlobalKey();
  GlobalKey<DropDownCategsState> categs2Key = GlobalKey();
  var categName = '';
  var subCateg = '';
  var subCategs;
  String vista1 = 'Seleccionar categoría';
  String vista2 = 'Seleccionar categoría';
  TransformationController controllerTransform = TransformationController();
  var initialControllerValue;
  bool editName = false;
  FocusNode editNameFocus = FocusNode();
  List<String> updateFields = ['', '', ''];

  int paginaActual = 1;
  List<Widget> paginas = [
    AddPhoto(),
    Ticketlist(),
  ];

  @override
  void initState() {
    subCategs = DropDownCategs(
        (value) => subCateg = value.toString(), widget.ticketData['categ2'], [],
        key: categs2Key);
    updateFields[0] = widget.ticketData['ticketName'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var dimension = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset('lib/assets/icons/Burger_Menu.svg'),
          onPressed: () => changePageFade(Menu(), context),
        ),
        title: Container(
            padding: EdgeInsets.fromLTRB(60, 30, 60, 30),
            child: SvgPicture.asset('lib/assets/Slang/IconHorizontal.svg')),
        actions: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.person)),
        ],
        backgroundColor: Color(0xFF011A58),
      ),
      body:

          ///paginaActual < 2 ? paginas[paginaActual] :

          Container(
        width: double.infinity,
        height: double.infinity,
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("lib/assets/backgrounds/fondo2.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Opacity(
              opacity: 0.50,
              child: Container(
                color: Color(0xFF415382),
                width: double.infinity,
                height: 25,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text('\t\tTickets > Archivador > ',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'IBM Plex Sans',
                            color: Colors.white)),
                    Text(
                      'Ticket',
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
            ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            dimension.width * 0.076, 0, 0, 0),
                        width: dimension.width * 0.55,
                        height: dimension.height * 0.39,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xFF011A58), width: 4),
                        ),
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
                      Container(
                        width: dimension.width * 0.076,
                        child: IconButton(
                          onPressed: () => changePageFadeRemoveUntil(DashBoard(paginaActual: 1), context),
                          icon: Icon(Icons.cancel),
                          padding: EdgeInsets.zero,
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                    child: Column(children: [
                      Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Nombre:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff011A58))),
                              SizedBox(width: 20),
                              Flexible(
                                child: TextFormField(
                                  focusNode: editNameFocus,
                                  enabled: editName,
                                  initialValue: widget.ticketData['ticketName']
                                      .toString(),
                                  autocorrect: false,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide.none),
                                    contentPadding:
                                        EdgeInsets.all(dimension.width * 0.015),
                                    filled: true,
                                    fillColor: Colors.transparent,
                                  ),
                                  onChanged: (value) => updateFields[0] = value,
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      editName = true;
                                    });
                                    Future.delayed(
                                        const Duration(milliseconds: 10), () {
                                      setState(() {
                                        editNameFocus.requestFocus();
                                      });
                                    });
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: blue100,
                                  ))
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
                                        child: DropDownCategs(
                                            (value) => {
                                                  auxDropDownDict(value),
                                                  updateFields[1] = value
                                                },
                                            widget.ticketData['categ1'],
                                            json
                                                .decode(
                                                    prefs!.getString('categs')!)
                                                .keys
                                                .toList(),
                                            key: categs1Key),
                                      ),
                                      Row(children: [
                                        IconButton(
                                          icon: Icon(
                                              Icons.add_circle_outline_outlined,
                                              color: Color(0xff011A58)),
                                          padding: EdgeInsets.zero,
                                          onPressed: () {},
                                        ),
                                      ])
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
                                        child: subCategs,
                                      ),
                                      Row(children: [
                                        IconButton(
                                          padding: EdgeInsets.zero,
                                          icon: Icon(
                                              Icons.add_circle_outline_outlined,
                                              color: Color(0xff011A58)),
                                          onPressed: () {
                                            //chooseCategNoBug(2);
                                          },
                                        ),
                                      ])
                                    ]),
                              ),
                            ]),
                      ),
                    ]),
                  ),
                ]),
            Container(
              color: Color(0xFFECEEF3),
              height: dimension.height * 0.062,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: dimension.height * 0.043,
                    width: dimension.width * 0.205,
                    child: IconButton(
                      icon: SvgPicture.asset('lib/assets/icons/Eliminar.svg'),
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        DB.delete(widget.ticketData['id']);
                        //Debería ser con pop
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DashBoard(paginaActual: 1)),
                        ).then((value) {
                          setState(() {});
                        });
                      },
                    ),
                  ),
                  Container(
                    height: dimension.height * 0.043,
                    width: dimension.width * 0.205,
                    child: IconButton(
                        icon: SvgPicture.asset('lib/assets/icons/Guardar.svg'),
                        padding: EdgeInsets.zero,
                        onPressed: () async => {
                              DB.updateTicket(
                                  updateFields, await widget.ticketData['id']),
                              setState(() {})
                            }),
                  ),
                  Container(
                    alignment: end,
                    height: dimension.height * 0.043,
                    width: dimension.width * 0.205,
                    child: IconButton(
                      icon: SvgPicture.asset('lib/assets/icons/Compartir.svg'),
                      padding: EdgeInsets.zero,
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
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF011A58),
        onTap: (index) {
          setState(() {
            index == 0
                ? {
                    Navigator.pop(context),
                    changePageFadeRemoveUntil(DashBoard(), context)
                  }
                : Navigator.pop(context);
          });
        },
        currentIndex: paginaActual,
        items: [
          BottomNavigationBarItem(
              icon: (paginaActual == 0)
                  ? SvgPicture.asset(
                      'lib/assets/icons/Selected_NuevoTicket.svg',
                      height: 52,
                      width: 64,
                    )
                  : SvgPicture.asset(
                      'lib/assets/icons/NuevoTicket.svg',
                      height: 52,
                      width: 64,
                    ),
              label: 'Nuevo ticket'),
          BottomNavigationBarItem(
            icon: (paginaActual != 0)
                ? SvgPicture.asset(
                    'lib/assets/icons/Selected_Archivador.svg',
                    height: 52,
                    width: 64,
                  )
                : SvgPicture.asset(
                    'lib/assets/icons/Archivador.svg',
                    height: 52,
                    width: 64,
                  ),
            label: 'Archivador',
          )
        ],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 6,
      ),
    );
  }

  void auxDropDownDict(dynamic value) {
    setState(() {
      subCateg = 'Seleccionar';
      subCategs = DropDownCategs(
          (value) => setState(() {
                subCateg = value.toString();
                updateFields[2] = value;
              }),
          subCateg,
          List<String>.from(json.decode(prefs!.getString('categs'))[value])
            ..add('Todas'),
          key: categs2Key);
    });

    categName = value.toString();
  }
}
