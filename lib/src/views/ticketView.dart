import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:slang_mobile/src/views/addPhoto.dart';
import 'package:slang_mobile/src/views/dashboard.dart';
import 'package:slang_mobile/src/views/menu.dart';
import 'package:slang_mobile/src/views/ticketlist.dart';
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
  var categ1 = '';
  var categ2 = '';
  String vista1 = 'Seleccionar categoría';
  String vista2 = 'Seleccionar categoría';
  TransformationController controllerTransform = TransformationController();
  var initialControllerValue;

  int paginaActual = 1;
  List<Widget> paginas = [
    AddPhoto(),
    Ticketlist(),
  ];
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
            child: SvgPicture.asset(
                'lib/assets/Slang/IconHorizontal.svg')),
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
                              initialControllerValue =
                                  controllerTransform.value;
                            },
                            onInteractionEnd: (details) {
                              controllerTransform.value =
                                  initialControllerValue;
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
                            onPressed: () => Navigator.pop(context),
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
                                Text(widget.ticketData['ticketName'].toString(),
                                    style: TextStyle(color: Color(0xff011A58))),
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
                                              (value) =>
                                                  categ1 = value.toString(),
                                              vista1,
                                              [],
                                              key: categs1Key),
                                        ),
                                        Row(children: [
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
                                          child: DropDownCategs(
                                              (value) =>
                                                  categ2 = value.toString(),
                                              vista2,
                                              [],
                                              key: categs2Key),
                                        ),
                                        Row(children: [
                                          IconButton(
                                            padding: EdgeInsets.zero,
                                            icon: Icon(
                                                Icons
                                                    .add_circle_outline_outlined,
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
                              icon: SvgPicture.asset(
                                  'lib/assets/icons/Eliminar.svg'),
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
                          Container(
                            height: dimension.height * 0.043,
                            width: dimension.width * 0.205,
                            child: IconButton(
                              icon: SvgPicture.asset(
                                  'lib/assets/icons/Guardar.svg'),
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
                          Container(
                            alignment: end,
                            height: dimension.height * 0.043,
                            width: dimension.width * 0.205,
                            child: IconButton(
                              icon: SvgPicture.asset(
                                  'lib/assets/icons/Compartir.svg'),
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
                  ])),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF011A58),
        onTap: (index) {
          setState(() {
            index == 0
                ? {
                    Navigator.pop(context),
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (c, a1, a2) => DashBoard(),
                          transitionsBuilder: (c, anim, a2, child) =>
                              FadeTransition(opacity: anim, child: child),
                          transitionDuration: Duration(milliseconds: 400),
                        ))
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
}
