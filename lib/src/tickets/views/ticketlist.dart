import 'package:slang_mobile/src/tickets/functions/sqlite.dart';
import 'package:slang_mobile/src/tickets/views/ticketView.dart';
import 'package:slang_mobile/src/tickets/functions/utilidades.dart';
import 'package:slang_mobile/src/tickets/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:path_provider/path_provider.dart';

var textoFechaInicio = 'Inicio';
var textoFechaFin = 'Fin';
var newDateRange;
var end;
bool isVisibleFiltring = false;
bool isVisibleDelete = false;
bool isVisibleDriveConection = true;
bool isVisibleSelectAll = false;

class Ticketlist extends StatefulWidget {
  @override
  State<Ticketlist> createState() => TicketlistState();
}

class TicketlistState extends State<Ticketlist> {
  final dateController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  var img = Image.asset('lib/assets/ticketRobot.png', scale: 5);
  var categs1Key;
  var categs2Key;
  var categs1;
  var categs2;
  var categ1 = '';
  var categ2 = '';
  bool loading = true;
  DateTimeRange dateRange =
      DateTimeRange(start: DateTime(2022, 03, 28), end: DateTime(2025, 03, 28));
  var isSelected = false;
  Color cardColor = Color.fromARGB(255, 209, 228, 243);

  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      loading = false;
      setState(() {});
    });
    categs1 = DropDownCategs((value) => auxFilterCateg(1, value),
        'Seleccionar categoria', 'categList1',
        key: categs1Key);
    categs2 = DropDownCategs((value) => auxFilterCateg(2, value),
        'Seleccionar subcategoría', 'categList2',
        key: categs2Key);
    super.initState();
  }

  @override
  void dispose() {
    categ1 = '';
    categ2 = '';
    textoFechaInicio = 'Inicio';
    textoFechaFin = 'Fin';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    categs1Key = GlobalKey();
    categs2Key = GlobalKey();
    return FutureBuilder(
        future: Future.wait([
          getPrefs(),
          DB.filter(textoFechaInicio, textoFechaFin, categ1, categ2)
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (loading) {
            return Container(
                width: double.infinity,
                height: double.infinity,
                color: Color(0xffFAFBF8),
                child: Center(
                    child:
                        Image.asset('lib/assets/loadSlang.gif', scale: 1.1)));
          }
          var ticketList = snapshot.data![1];
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
                        padding: EdgeInsets.fromLTRB(12, 5, 10, 5),
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(children: [
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                  icon: isVisibleSelectAll
                                      ? Icon(Icons.check_box,
                                          color: Color(0xFF011A58), size: 25)
                                      : Icon(Icons.indeterminate_check_box,
                                          color: Color(0xFF011A58), size: 25),
                                  onPressed: () {
                                    setState(() {
                                      isVisibleSelectAll = !isVisibleSelectAll;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Seleccionar todos',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'IBM Plex Sans',
                                      color: Color(0xFF011A58)),
                                ),
                              ]),
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              icon: isVisibleFiltring
                                  ? Icon(Icons.filter_alt_off,
                                      color: Color(0xFF011A58), size: 25)
                                  : Icon(Icons.filter_alt,
                                      color: Color(0xFF011A58), size: 25),
                              onPressed: () {
                                setState(() {
                                  isVisibleFiltring = !isVisibleFiltring;
                                });
                              },
                            ),
                          ],
                        )),
                    Visibility(
                      visible: isVisibleFiltring,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                        fontSize: 16,
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
                                        fontSize: 16,
                                        fontFamily: 'IBM Plex Sans',
                                        color: Color(0xFF011A58)),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  categs1
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
                                        fontSize: 16,
                                        fontFamily: 'IBM Plex Sans',
                                        color: Color(0xFF011A58)),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  categs2
                                ],
                              ),
                            ),
                            Divider()
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Expanded(
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.builder(
                            controller: scrollController,
                            itemCount: snapshot.data![1].length,
                            itemBuilder: (BuildContext context, int index) {
                              var vendor = ticketList[index]
                                  .toMap()['issuer']
                                  .split('\n')[0]
                                  .toString();
                              return Card(
                                color: cardColor,
                                child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      ListTile(
                                        onTap: () {
                                          changePageFade(
                                              TicketView(
                                                  ticketList[index].toMap()),
                                              context);
                                        },
                                        selected: isSelected,
                                        title: Container(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      vendor.substring(
                                                          0,
                                                          vendor.length > 14
                                                              ? 14
                                                              : vendor.length),
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                    Text(ticketList[index]
                                                            .toMap()['total']
                                                            .toString() +
                                                        '€')
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text(ticketList[index]
                                                        .toMap()['date']),
                                                    Text(ticketList[index]
                                                        .toMap()['hour'])
                                                  ],
                                                ),
                                                TextButton(
                                                  child: Text('Ver foto',
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .underline)),
                                                  onPressed: () {
                                                    changePageFade(
                                                        TicketView(
                                                            ticketList[index]
                                                                .toMap()),
                                                        context);
                                                  },
                                                ),
                                                Visibility(
                                                  visible: isVisibleDelete,
                                                  child: IconButton(
                                                    icon: Icon(Icons.delete),
                                                    iconSize: 28,
                                                    color: Color.fromARGB(
                                                        255, 161, 30, 21),
                                                    onPressed: () {
                                                      dialogRemoveTicket(
                                                              context,
                                                              ticketList[index]
                                                                      .toMap()[
                                                                  'id'])
                                                          .then((value) {
                                                        if (value) {
                                                          setState(() {});
                                                        }
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(ticketList[index]
                                                    .toMap()['date']),
                                                Text(ticketList[index]
                                                    .toMap()['hour'])
                                              ],
                                            ),
                                          ],
                                        )),
                                      ),
                                    ]),
                              );
                            }),
                      ),
                    ),
                    Visibility(
                      visible: isVisibleSelectAll,
                      child: Container(
                          padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                          color: Color(0xFFECEEF3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 45,
                                width: 45,
                                child: Column(
                                  children: [
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: BoxConstraints(),
                                      icon: Icon(Icons.delete_outlined,
                                          color: Color(0xFF011A58)),
                                      onPressed: () {
                                        setState(() {
                                          isVisibleDelete = !isVisibleDelete;
                                        });
                                      },
                                    ),
                                    Text(
                                      'Eliminar',
                                      style: TextStyle(
                                          fontFamily: 'IBM Plex Sans',
                                          fontSize: 12,
                                          color: Color(0xFF011A58)),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: BoxConstraints(),
                                      icon: Icon(
                                        Icons.share_outlined,
                                        color: Color.fromRGBO(1, 26, 88, 1),
                                      ),
                                      onPressed: () async {
                                        var storageDir =
                                            await getExternalStorageDirectory();
                                        if (!storageDir!.listSync().isEmpty) {
                                          emptyAppDir();
                                        }
                                        createExcelLista(ticketList)
                                            .then((result) async {
                                          /*Aquí estaba intentando probar lo de subir el zip a Drive
                                          await DriveService().upload(
                                              '/storage/emulated/0/Android/data/com.example.slang_mobile/files/Tickets.zip');*/
                                          await FlutterShare.shareFile(
                                                  title: 'Lista de facturas',
                                                  filePath:
                                                      '/storage/emulated/0/Android/data/com.example.slang_mobile/files/Tickets.zip',
                                                  text:
                                                      'Comparto contigo este excel con la lista de tickets y la foto de cada ticket')
                                              .then((value) => null);
                                        });
                                      },
                                    ),
                                    Text(
                                      'Compartir',
                                      style: TextStyle(
                                          fontFamily: 'IBM Plex Sans',
                                          fontSize: 12,
                                          color: Color(0xFF011A58)),
                                    ),
                                  ],
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
        categ1 = value;
      } else {
        categ2 = value;
      }
    });
  }
}
