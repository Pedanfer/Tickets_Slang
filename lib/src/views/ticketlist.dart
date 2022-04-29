import 'package:exploration_planner/src/functions/Google.dart';
import 'package:exploration_planner/src/functions/sqlite.dart';
import 'package:exploration_planner/src/utils/constants.dart';
import 'package:exploration_planner/src/views/login_page.dart';
import 'package:exploration_planner/src/views/ticketView.dart';
import 'package:exploration_planner/src/functions/utilidades.dart';
import 'package:exploration_planner/src/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:path_provider/path_provider.dart';

var textoFechaInicio = 'Fecha inicio';
var textoFechaFin = 'Fecha fin';
var newDateRange;
var end;
bool isVisibleFiltring = false;
bool isVisibleDelete = false;
bool isVisibleDriveConection = true;

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
  DateTimeRange dateRange = DateTimeRange(start: DateTime(2022, 03, 28), end: DateTime(2025, 03, 28));
  var isSelected = false;
  Color cardColor = Color.fromARGB(255, 209, 228, 243);

  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      loading = false;
      setState(() {});
    });
    categs1 = DropDownCategs((value) => auxFilterCateg(1, value), 'Elija categoría', 'categList1', key: categs1Key);
    categs2 = DropDownCategs((value) => auxFilterCateg(2, value), 'Elija categoría', 'categList2', key: categs2Key);
    super.initState();
  }

  @override
  void dispose() {
    categ1 = '';
    categ2 = '';
    textoFechaInicio = 'Fecha inicio';
    textoFechaFin = 'Fecha fin';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    categs1Key = GlobalKey();
    categs2Key = GlobalKey();
    return FutureBuilder(
        future: Future.wait([getPrefs(), DB.filter(textoFechaInicio, textoFechaFin, categ1, categ2)]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (loading) {
            return Container(
                width: double.infinity,
                height: double.infinity,
                color: Color(0xffFAFBF8),
                child: Center(child: Image.asset('lib/assets/loadSlang.gif', scale: 1.1)));
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
                    Container(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        color: blue100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              child: Text(
                                'Mis tickets',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16, color: Colors.white),
                                textScaleFactor: 1.3,
                              ),
                            ),
                            IconButton(
                              icon: isVisibleDelete
                                  ? Icon(Icons.delete_forever, color: Colors.white, size: 28)
                                  : Icon(Icons.delete, color: Colors.white, size: 28),
                              onPressed: () {
                                setState(() {
                                  isVisibleDelete = !isVisibleDelete;
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.download,
                                color: Colors.white,
                                size: 30,
                              ),
                              onPressed: () async {
                                var storageDir = await getExternalStorageDirectory();
                                if (!storageDir!.listSync().isEmpty) {
                                  emptyAppDir();
                                }
                                createExcelLista(ticketList).then((result) async {
                                  await FlutterShare.shareFile(
                                          title: 'Lista de facturas',
                                          filePath:
                                              '/storage/emulated/0/Android/data/com.example.exploration_planner/files/Tickets.zip',
                                          text:
                                              'Comparto contigo este excel con la lista de tickets y la foto de cada ticket')
                                      .then((value) => null);
                                });
                              },
                            ),
                            IconButton(
                              icon: isVisibleDriveConection ? Icon(Icons.add_to_drive) : Icon(Icons.no_cell),
                              color: Colors.white,
                              onPressed: () async {
                                if (isVisibleDriveConection) {
                                  await signIn().then((result) {
                                    setState(() {});
                                  });
                                } else {
                                  await signOut().then((result) {
                                    setState(() {});
                                  });
                                }

                                isVisibleDriveConection = !isVisibleDriveConection;

                                await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(builder: (context, setState) {
                                        return AlertDialog(
                                          insetPadding: EdgeInsets.all(dimension.width * 0.07),
                                          title: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Visibility(
                                                visible: !isVisibleDriveConection,
                                                child: Text(
                                                  'Conectado a Drive\n exitosamente',
                                                  style: TextStyle(fontSize: 18),
                                                ),
                                              ),
                                              Visibility(
                                                visible: isVisibleDriveConection,
                                                child: Text(
                                                  'Desconectado a Drive\n exitosamente',
                                                  style: TextStyle(fontSize: 18),
                                                ),
                                              )
                                            ],
                                          ),
                                          actions: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                TextButton(
                                                  child: Text('Aceptar'),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            )
                                          ],
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                                        );
                                      });
                                    });
                              },
                            ),
                            IconButton(
                              icon: isVisibleFiltring
                                  ? Icon(Icons.filter_alt_off, color: Colors.white, size: 28)
                                  : Icon(Icons.filter_alt, color: Colors.white, size: 28),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                    child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: Color.fromARGB(255, 0, 118, 197)),
                                  onPressed: pickDateRange,
                                  child: Text(textoFechaInicio, textScaleFactor: 1.2),
                                )),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: Color.fromARGB(255, 18, 86, 189)),
                                  onPressed: pickDateRange,
                                  child: Text(textoFechaFin, textScaleFactor: 1.2),
                                ))
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [categs1, categs2],
                          ),
                        ],
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
                              var vendor = ticketList[index].toMap()['issuer'].split('\n')[0].toString();
                              return Card(
                                color: cardColor,
                                child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
                                  ListTile(
                                    onTap: ()  {  changePageFade(TicketView(ticketList[index].toMap()), context);},
                                    selected: isSelected,
                                    title: Container(
                                        child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              vendor.substring(0, vendor.length > 14 ? 14 : vendor.length),
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            Text(ticketList[index].toMap()['total'].toString() + '€')
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(ticketList[index].toMap()['date']),
                                            Text(ticketList[index].toMap()['hour'])
                                          ],
                                        ),
                                        Visibility(
                                          visible: isVisibleDelete,
                                          child: IconButton(
                                            icon: Icon(Icons.delete),
                                            iconSize: 28,
                                            color: Color.fromARGB(255, 161, 30, 21),
                                            onPressed: () {
                                              dialogRemoveTicket(context, ticketList[index].toMap()['id'])
                                                  .then((value) {
                                                if (value) {
                                                  setState(() {});
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    )),
                                  ),
                                ]),
                              );
                            }),
                      ),
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
