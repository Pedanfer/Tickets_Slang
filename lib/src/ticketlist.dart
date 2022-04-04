import 'dart:io';
import 'package:exploration_planner/src/ticketView.dart';
import 'package:exploration_planner/src/utilidades.dart';
import 'package:exploration_planner/src/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';

class Ticketlist extends StatefulWidget {
  @override
  State<Ticketlist> createState() => TicketlistState();
}

var textoFechaInicio = 'Fecha inicio';
var textoFechaFin = 'Fecha fin';
var newDateRange;
var end;
var categs;
bool filtradoDate = false;
bool lastIsCateg = false;
bool isVisibleFiltring = false;
bool isVisibleDelete = false;

class TicketlistState extends State<Ticketlist> {
  final dateController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  var img = Image.asset('lib/assets/ticketRobot.png', scale: 5);
  var unfilteredFiles = getFiles();
  var filteredFiles = getFiles();
  var categFilteredFiles = getFiles();
  var dateFilteredFiles = getFiles();
  bool filtradoCateg = false;
  bool filtradoDate = false;
  bool lastIsCateg = false;
  var categsKey;
  DateTimeRange dateRange =
      DateTimeRange(start: DateTime(2022, 03, 28), end: DateTime(2025, 03, 28));
  var isSelected = false;
  Color cardColor = Colors.grey;

  @override
  void dispose() {
    textoFechaInicio = 'Fecha inicio';
    textoFechaFin = 'Fecha fin';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    categsKey = GlobalKey();
    categs = DropDownCategs((value) => filterByCategory(value.toString(), 1),
        'Elija categoría', 'categList1',
        key: categsKey);
    return FutureBuilder(
        future: getPrefs(),
        builder: (context, snapshot) {
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
                                createExcelLista(filteredFiles).then((result) async {
                                  await FlutterShare.shareFile(title: 'Lista de facturas', filePath: '/storage/emulated/0/Android/data/com.example.exploration_planner/files/Output.xlsx', text: 'Comparto contigo este excel con la lista de tickets');
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
                                      style: TextStyle(color: Colors.white)),
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
                                  child: Text(textoFechaFin),
                                ))
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              categs,
                              /*Expanded(
                            child: DropDownCategs(
                                (value) =>
                                    filterByCategory(value.toString(), 2),
                                'Elija categoría',
                                'categList2')),*/
                            ],
                          ),
                          /*Expanded(
                            child: DropDownCategs(
                                (value) =>
                                    filterByCategory(value.toString(), 2),
                                'Elija categoría',
                                'categList2')),*/
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
                            itemCount: filteredFiles.length,
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
                                                  TicketView(
                                                      filteredFiles[index]
                                                          .path
                                                          .toString()),
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
                                                child: Image.file(
                                                    filteredFiles[index])),
                                            Text(filteredFiles[index]
                                                .toString()
                                                .substring(78, 88)),
                                            Text(filteredFiles[index]
                                                .toString()
                                                .substring(89, 94)
                                                .replaceAll('-', ':')),
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
                                                          filteredFiles[index]
                                                              .path
                                                              .split('/')
                                                              .last)
                                                      .then((value) {
                                                    if (value) {
                                                      setState(() {
                                                        filteredFiles =
                                                            getFiles();
                                                      });
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
    categsKey.currentState!.changeHint('Elija categoría');
    var newDateRange = await showDateRangePicker(
        context: context,
        initialDateRange: dateRange,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (newDateRange == null) return;

    setState(() {
      scrollController.jumpTo(scrollController.position.minScrollExtent);
      var digitMonth1 = newDateRange.start.month < 10 ? 0 : '';
      var digitMonth2 = newDateRange.end.month < 10 ? 0 : '';
      var digitDay1 = newDateRange.start.day < 10 ? 0 : '';
      var digitDay2 = newDateRange.end.day < 10 ? 0 : '';
      textoFechaInicio =
          '${newDateRange.start.year}-$digitMonth1${newDateRange.start.month}-$digitDay1${newDateRange.start.day}';
      textoFechaFin =
          '${newDateRange.end.year}-$digitMonth2${newDateRange.end.month}-$digitDay2${newDateRange.end.day}';
      var listToFilter =
          filtradoCateg && !lastIsCateg ? categFilteredFiles : unfilteredFiles;

      filteredFiles = listToFilter
          .where((file) =>
              (DateTime.parse(file.toString().substring(78, 88))
                      .isAfter(DateTime.parse(textoFechaInicio)) ||
                  DateTime.parse(file.toString().substring(78, 88))
                      .isAtSameMomentAs(DateTime.parse(textoFechaInicio))) &&
              (DateTime.parse(file.toString().substring(78, 88))
                      .isBefore(DateTime.parse(textoFechaFin)) ||
                  DateTime.parse(file.toString().substring(78, 88))
                      .isAtSameMomentAs(DateTime.parse(textoFechaFin))))
          .toList();
    });
    dateFilteredFiles = List<File>.from(filteredFiles);
    filtradoDate = true;
    lastIsCateg = false;
  }

  void filterByCategory(String value, int num) {
    lastIsCateg = true;
    var listToFilter = filtradoDate ? dateFilteredFiles : unfilteredFiles;
    setState(() {
      var index = num == 1 ? 0 : 1;
      filteredFiles = listToFilter
          .where((file) =>
              file.path.split('/').last.split('.')[1].split('|')[index] ==
              value)
          .toList();
    });
    categFilteredFiles = List<File>.from(filteredFiles);
    filtradoCateg = true;
  }
}
