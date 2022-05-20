import 'dart:convert';
import 'dart:io';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:path_provider/path_provider.dart';
import 'package:slang_mobile/main.dart';
import 'package:slang_mobile/src/functions/sqlite.dart';
import 'package:slang_mobile/src/utils/ticket.dart';
import 'package:slang_mobile/src/views/ticketView.dart';
import '../functions/Google.dart';
import '../functions/utilidades.dart';
import '../utils/constants.dart';
import '../utils/widgets.dart';

var textoFechaInicio = 'Inicio';
var textoFechaFin = 'Fin';
var newDateRange;
var end;
bool isVisibleFiltring = false;
bool isSelectedAll = false;
bool isVisibleOffline = true;
bool isVisibleOnline = true;
bool isVisibleSelected = false;
var isSelected = <bool>[];
var ticketsSelected = <Ticket>[];

class Ticketlist extends StatefulWidget {
  @override
  State<Ticketlist> createState() => TicketlistState();
}

class TicketlistState extends State<Ticketlist> {
  final dateController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  var img = Image.asset('lib/assets/Slang/ticketRobot.png', scale: 5);
  var categs1Key;
  var categs2Key;
  var categs;
  var subCategs;
  var categName = '';
  var subCateg = '';
  bool loading = true;
  List<bool> checksDrive = [false, false];
  DateTimeRange dateRange =
      DateTimeRange(start: DateTime(2022, 03, 28), end: DateTime(2025, 03, 28));

  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      loading = false;
      setState(() {});
    });
    categs = DropDownCategs((value) => {auxDropDownDict(value)}, 'Seleccionar',
        json.decode(prefs!.getString('categs')!).keys.toList(),
        key: categs1Key);
    subCategs = DropDownCategs(
        (value) => subCateg = value.toString(), 'Seleccionar', [],
        key: categs2Key);
    super.initState();
  }

  @override
  void dispose() {
    categName = '';
    subCateg = '';
    textoFechaInicio = 'Inicio';
    textoFechaFin = 'Fin';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dimension = MediaQuery.of(context).size;
    WidgetsFlutterBinding.ensureInitialized();
    categs1Key = GlobalKey();
    categs2Key = GlobalKey();

    return FutureBuilder(
        future: Future.wait([
          getPrefs(),
          DB.filter(
              textoFechaInicio, textoFechaFin, categName, subCateg, checksDrive)
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (loading) {
            return Container(
                width: double.infinity,
                height: double.infinity,
                color: Color(0xffFAFBF8),
                child: Center(
                    child: Image.asset('lib/assets/Slang/loadSlang2.gif')));
          }
          List<Ticket> ticketList = snapshot.data![1];
          while (isSelected.length < ticketList.length) {
            isSelected.add(false);
          }

          var encontrado = false;
          if (isSelectedAll == true) {
            encontrado = true;
          }
          for (int i = 0; i < isSelected.length; i++) {
            if (isSelected[i] != false) {
              encontrado = true;
            }
          }
          if (encontrado == true) {
            isVisibleSelected = true;
          } else {
            isVisibleSelected = false;
          }

          return Scaffold(
            body: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Opacity(
                      opacity: 0.95,
                      child: Container(
                          color: Color(0xFF415382),
                          width: double.infinity,
                          height: 25,
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Text(
                                '\t\tTickets > ',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'IBM Plex Sans',
                                    color: Colors.white),
                              ),
                              Text(
                                'Archivador',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'IBM Plex Sans',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                    ),
                    Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 0.5, color: Colors.grey),
                          ),
                        ),
                        padding: EdgeInsets.fromLTRB(12, 5, 10, 5),
                        height: 35,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(children: [
                                SizedBox(
                                  width: dimension.width * 0.02,
                                ),
                                Container(
                                  width: dimension.width * 0.028,
                                  height: dimension.height * 0.01296,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                    icon: isSelectedAll
                                        ? Transform.scale(
                                            scale: 1.75,
                                            child: SvgPicture.asset(
                                                'lib/assets/icons/checked-selected.svg'),
                                          )
                                        : Transform.scale(
                                            scale: 1.75,
                                            child: SvgPicture.asset(
                                                'lib/assets/icons/checked.svg'),
                                          ),
                                    onPressed: () {
                                      setState(() {
                                        isSelectedAll = !isSelectedAll;

                                        for (var i = 0;
                                            i < isSelected.length;
                                            i++) {
                                          isSelected[i] = isSelectedAll;
                                        }
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: dimension.width * 0.024,
                                ),
                                Container(
                                  height: dimension.height * 0.024,
                                  width: dimension.width * 0.2827,
                                  child: Text(
                                    'Todos',
                                    style: TextStyle(
                                        fontFamily: 'IBM Plex Sans',
                                        color: Color(0xFF011A58)),
                                  ),
                                ),
                              ]),
                            ),
                            Container(
                              width: dimension.width * 0.0467,
                              height: dimension.height * 0.0216,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                                icon: isVisibleFiltring
                                    ? SvgPicture.asset(
                                        'lib/assets/icons/filter-relleno.svg')
                                    : SvgPicture.asset(
                                        'lib/assets/icons/filter-hueco.svg'),
                                onPressed: () {
                                  setState(() {
                                    isVisibleFiltring = !isVisibleFiltring;
                                  });
                                },
                              ),
                            ),
                          ],
                        )),
                    Visibility(
                      visible: isVisibleFiltring,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Filtros:',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'IBM Plex Sans',
                                        color: Color(0xFF011A58),
                                        decoration: TextDecoration.underline,
                                        decorationStyle:
                                            TextDecorationStyle.dashed,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          // LIMPIA EL FILTRO
                                        },
                                        child: Text(
                                          'Limpiar filtro',
                                          style: TextStyle(
                                              fontSize: 14,
                                              decoration:
                                                  TextDecoration.underline,
                                              fontFamily: 'IBM Plex Sans'),
                                        ))
                                  ]),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 24,
                                child: Row(
                                  children: [
                                    Text(
                                      'Fecha Creación',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'IBM Plex Sans',
                                          color: Color(0xFF011A58)),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary:
                                              Color.fromARGB(255, 0, 118, 197)),
                                      onPressed: pickDateRange,
                                      child: Text(textoFechaInicio,
                                          textScaleFactor: 1.2),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary:
                                              Color.fromARGB(255, 18, 86, 189)),
                                      onPressed: pickDateRange,
                                      child: Text(textoFechaFin,
                                          textScaleFactor: 1.2),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 30,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Categoria',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'IBM Plex Sans',
                                          color: Color(0xFF011A58)),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    categs,
                                  ],
                                ),
                              ),
                              Container(
                                height: 30,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Subcategoria',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'IBM Plex Sans',
                                          color: Color(0xFF011A58)),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    subCategs
                                  ],
                                ),
                              ),
                              Container(
                                height: 30,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Almacenado en Drive',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'IBM Plex Sans',
                                          color: Color(0xFF011A58)),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: Transform.translate(
                                        offset: Offset(
                                            0, -2 * (dimension.height * 0.008)),
                                        child: CustomCheckBox(
                                          color: blue100,
                                          dimension: dimension,
                                          offsetCheck: 0,
                                          offsetText: -22,
                                          text: [TextSpan(text: 'Sí')],
                                          func: (value) {
                                            setState(() {
                                              checksDrive[0] = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Transform.translate(
                                        offset: Offset(
                                            0, -2 * (dimension.height * 0.008)),
                                        child: CustomCheckBox(
                                          color: blue100,
                                          dimension: dimension,
                                          offsetCheck: 0,
                                          offsetText: -22,
                                          text: [TextSpan(text: 'No')],
                                          func: (value) {
                                            setState(() {
                                              checksDrive[1] = value;
                                            });
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.grey,
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: snapshot.data![1].length,
                          itemBuilder: (BuildContext context, int index) {
                            var vendor = ticketList[index]
                                .toMap()['issuer']
                                .split('\n')[0]
                                .toString();
                            if (vendor == '') {
                              vendor = '---';
                            }
                            var vendor2 = vendor.split(' ')[0];

                            var fechor =
                                ticketList[index].toMap()['date'].toString();

                            if (fechor == '') {
                              fechor = 'Sin Fecha';
                            }
                            var houror =
                                ticketList[index].toMap()['hour'].toString();
                            if (houror == '') {
                              houror = '-- : -- : --';
                            } else {
                              houror = houror.substring(0, 5);
                              ;
                            }
                            var synchronizor =
                                ticketList[index].toMap()['synchronized'];
                            return Card(
                              margin: EdgeInsets.fromLTRB(0, 0.3, 0, 0.3),
                              child: ListTile(
                                onTap: () {
                                  changePageFade(
                                      TicketView(ticketList[index].toMap()),
                                      context);
                                },
                                title: Container(
                                  height: 60,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        width: dimension.width * 0.03,
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          constraints: BoxConstraints(),
                                          icon: isSelectedAll
                                              ? Transform.scale(
                                                  scale: 1.5,
                                                  child: SvgPicture.asset(
                                                      'lib/assets/icons/checked-selected.svg'),
                                                )
                                              : (isSelected[index] == true
                                                  ? Transform.scale(
                                                      scale: 1.5,
                                                      child: SvgPicture.asset(
                                                          'lib/assets/icons/checked-selected.svg'),
                                                    )
                                                  : Transform.scale(
                                                      scale: 1.5,
                                                      child: SvgPicture.asset(
                                                          'lib/assets/icons/checked.svg'),
                                                    )),
                                          onPressed: () {
                                            setState(() {
                                              isSelected[index] =
                                                  !isSelected[index];

                                              if (isSelectedAll == true) {
                                                isSelectedAll = false;
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                      Container(
                                          width: dimension.width * 0.30,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                vendor2.length > 10
                                                    ? vendor2
                                                        .substring(0, 10)
                                                        .toUpperCase()
                                                    : vendor2.toUpperCase(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'IBM Plex Sans',
                                                    color: Color(0xFF011A58)),
                                              ),
                                            ],
                                          )),
                                      Container(
                                          width: dimension.width * 0.25,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                fechor,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'IBM Plex Sans',
                                                    color: Color(0xFF011A58)),
                                              ),
                                            ],
                                          )),
                                      Container(
                                          width: dimension.width * 0.20,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                houror,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'IBM Plex Sans',
                                                    color: Color(0xFF011A58)),
                                              ),
                                            ],
                                          )),
                                      Container(
                                        width: dimension.width * 0.05,
                                        child: synchronizor == 1
                                            ? Icon(
                                                Icons.cloud_rounded,
                                                color: Color(0xFF011A58),
                                                size: 20,
                                              )
                                            : Icon(Icons.cloud_off_rounded,
                                                color: Color(0xFF011A58),
                                                size: 20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isVisibleSelected,
                      child: Container(
                          height: dimension.height * 0.062,
                          padding: EdgeInsets.fromLTRB(
                              dimension.width * 0.15,
                              dimension.height * 0.008,
                              dimension.width * 0.15,
                              dimension.height * 0.008),
                          color: Color(0xFFECEEF3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: dimension.height * 0.086,
                                width: dimension.width * 0.205,
                                child: IconButton(
                                  icon: SvgPicture.asset(
                                      'lib/assets/icons/Eliminar.svg'),
                                  padding: EdgeInsets.zero,
                                  onPressed: () async {
                                    var aux = <bool>[];
                                    for (var i = 0;
                                        i < ticketList.length;
                                        i++) {
                                      if (isSelected[i] == true) {
                                        ticketsSelected.add(ticketList[i]);
                                      } else {
                                        aux.add(isSelected[i]);
                                      }
                                    }
                                    if (await dialogRemoveTicket(
                                        context, 1, ticketsSelected)) {
                                      setState(() {});
                                      ticketsSelected = [];
                                      isSelected = aux;
                                    }
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
                                  onPressed: () async {
                                    Directory? storageDir =
                                        await getExternalStorageDirectory();
                                    var fileList =
                                        await storageDir!.list().toList();
                                    if (fileList.isNotEmpty) {
                                      await emptyAppDir();
                                    }

                                    for (var i = 0;
                                        i < ticketList.length;
                                        i++) {
                                      if (isSelected[i] == true) {
                                        ticketsSelected.add(ticketList[i]);
                                      }
                                    }

                                    createZipWithExcel(ticketsSelected,
                                            storedDrive: false)
                                        .then(
                                      (result) async {
                                        await FlutterShare.shareFile(
                                                title: 'Lista de facturas',
                                                filePath: ticketsZipPath,
                                                text:
                                                    'Comparto contigo este excel con la lista de tickets y la foto de cada ticket')
                                            .then((value) => null);
                                      },
                                    );

                                    ticketsSelected = [];
                                  },
                                ),
                              ),
                              Container(
                                height: dimension.height * 0.043,
                                width: dimension.width * 0.205,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                  icon: SvgPicture.asset(
                                      'lib/assets/icons/GDrive.svg'),
                                  onPressed: () async {
                                    Directory? storageDir =
                                        await getExternalStorageDirectory();
                                    var fileList =
                                        await storageDir!.list().toList();
                                    if (fileList.isNotEmpty) {
                                      await emptyAppDir();
                                    }

                                    for (var i = 0;
                                        i < ticketList.length;
                                        i++) {
                                      if (isSelected[i] == true) {
                                        ticketsSelected.add(ticketList[i]);
                                      }
                                    }
                                    setState(() async {
                                      createZipWithExcel(ticketsSelected,
                                              storedDrive: true)
                                          .then((result) async {
                                        await uploadFiles();
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              Future.delayed(
                                                  Duration(seconds: 5), () {
                                                Navigator.pop(context, true);
                                              });
                                              return CustomAlertDialog(
                                                  'Almacenando los tickets seleccionados en Google Drive...',
                                                  dimension);
                                            });
                                      });
                                    });

                                    ticketsSelected = [];
                                  },
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                )),
          );
        });
  }

  void auxDropDownDict(dynamic value) {
    setState(() {
      subCateg = 'Seleccionar';
      subCategs = DropDownCategs(
          (value) => setState(() {
                subCateg = value.toString();
              }),
          subCateg,
          List<String>.from(json.decode(prefs!.getString('categs'))[value])
            ..add('Todas'),
          key: categs2Key);
    });

    categName = value.toString();
  }

  Future pickDateRange() async {
    var newDateRange = await showDateRangePicker(
        locale: Locale('es', ''),
        context: context,
        initialDateRange: dateRange,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (newDateRange == null) return;

    setState(() {
      textoFechaInicio = newDateRange.start.toString().substring(0, 10);
      textoFechaFin = newDateRange.end.toString().substring(0, 10);
    });
  }

  void auxFilterCateg(int num, String value) {
    setState(() {
      if (num == 1) {
        categName = value;
      } else {
        subCateg = value;
      }
    });
  }
}
