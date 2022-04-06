import 'package:exploration_planner/src/functions/sqlite.dart';
import 'package:exploration_planner/src/views/ticketView.dart';
import 'package:exploration_planner/src/functions/utilidades.dart';
import 'package:exploration_planner/src/utils/widgets.dart';
import 'package:flutter/material.dart';

var textoFechaInicio = 'Fecha inicio';
var textoFechaFin = 'Fecha fin';
var newDateRange;
var end;
bool isVisibleFiltring = false;
bool isVisibleDelete = false;

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
  DateTimeRange dateRange =
      DateTimeRange(start: DateTime(2022, 03, 28), end: DateTime(2025, 03, 28));
  var isSelected = false;
  Color cardColor = Colors.grey;

  @override
  void initState() {
    categs1 = DropDownCategs(
        (value) => auxFilterCateg(1, value), 'Elija categoría', 'categList1',
        key: categs1Key);
    categs2 = DropDownCategs(
        (value) => auxFilterCateg(2, value), 'Elija categoría', 'categList2',
        key: categs2Key);
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
        future: Future.wait([
          getPrefs(),
          DB.filter(textoFechaInicio, textoFechaFin, categ1, categ2)
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          var ticketList = snapshot.data![1];

          return Scaffold(
            body: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xff011A58),
                      Color(0xffA0A9C0),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        padding: EdgeInsets.fromLTRB(10, 35, 10, 5),
                        color: Color.fromARGB(255, 14, 117, 185),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              child: Text(
                                'Slang Ticket Manager',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                                textScaleFactor: 1.3,
                              ),
                            ),
                            IconButton(
                              icon: isVisibleDelete
                                  ? Icon(Icons.delete_forever)
                                  : Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  isVisibleDelete = !isVisibleDelete;
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.share),
                              onPressed: () {
                                setState(() {
                                  // COMPARTIR
                                });
                              },
                            ),
                            IconButton(
                              icon: isVisibleFiltring
                                  ? Icon(Icons.filter_alt_off)
                                  : Icon(Icons.filter_alt),
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
                                  style: ElevatedButton.styleFrom(
                                      primary:
                                          Color.fromARGB(255, 0, 118, 197)),
                                  onPressed: pickDateRange,
                                  child: Text(textoFechaInicio,
                                      textScaleFactor: 1.3),
                                )),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary:
                                          Color.fromARGB(255, 18, 86, 189)),
                                  onPressed: pickDateRange,
                                  child:
                                      Text(textoFechaFin, textScaleFactor: 1.3),
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
                              return Card(
                                color: cardColor,
                                child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      ListTile(
                                        selected: isSelected,
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (c, a1, a2) =>
                                                  TicketView(ticketList[index]
                                                      .toMap()),
                                              transitionsBuilder:
                                                  (c, anim, a2, child) =>
                                                      FadeTransition(
                                                          opacity: anim,
                                                          child: child),
                                              transitionDuration:
                                                  Duration(milliseconds: 700),
                                            ),
                                          );
                                        },
                                        title: Container(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                width: 60,
                                                height: 60,
                                                child: Image.memory(
                                                    ticketList[index]
                                                        .toMap()['photo'])),
                                            Column(
                                              children: [
                                                Text(ticketList[index]
                                                    .toMap()['date']),
                                                Text(ticketList[index]
                                                    .toMap()['hour'])
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(ticketList[index]
                                                    .toMap()['categ1']),
                                                Text(ticketList[index]
                                                    .toMap()['categ2'])
                                              ],
                                            ),
                                            Visibility(
                                              visible: isVisibleDelete,
                                              child: IconButton(
                                                icon: Icon(Icons.delete),
                                                iconSize: 30,
                                                color: Color.fromARGB(
                                                    255, 114, 14, 7),
                                                onPressed: () {
                                                  dialogRemoveReceipt(
                                                          context,
                                                          ticketList[index]
                                                              .toMap()['id'])
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
