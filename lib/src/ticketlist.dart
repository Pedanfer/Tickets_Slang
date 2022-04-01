import 'dart:io';

import 'package:exploration_planner/src/login_page.dart';
import 'package:exploration_planner/src/ticketView.dart';
import 'package:exploration_planner/src/utilidades.dart';
import 'package:exploration_planner/src/widgets.dart';
import 'package:flutter/material.dart';

class Ticketlist extends StatefulWidget {
  @override
  State<Ticketlist> createState() => TicketlistState();
}

var textoFechaInicio = 'Fecha inicio';
var textoFechaFin = 'Fecha fin';
var newDateRange;
var end;
var categs;
GlobalKey<DropDownCategsState> categsKey = GlobalKey();

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
  DateTimeRange dateRange =
      DateTimeRange(start: DateTime(2022, 03, 28), end: DateTime(2025, 03, 28));
  var isSelected = false;
  Color cardColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
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
                    SizedBox(height: dimension.height * 0.05),
                    Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                          onPressed: pickDateRange,
                          child: Text(textoFechaInicio),
                        )),
                        Expanded(
                            child: ElevatedButton(
                          onPressed: pickDateRange,
                          child: Text(textoFechaFin),
                        ))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: categs,
                          /*Expanded(
                            child: DropDownCategs(
                                (value) =>
                                    filterByCategory(value.toString(), 2),
                                'Elija categoría',
                                'categList2')),*/
                        )
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                          controller: scrollController,
                          itemCount: filteredFiles.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              color: cardColor,
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      selected: isSelected,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (c, a1, a2) =>
                                                TicketView(filteredFiles[index]
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
                                          IconButton(
                                            icon: Icon(Icons.delete_forever),
                                            iconSize: 30,
                                            color:
                                                Color.fromARGB(255, 114, 14, 7),
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
                                                    filteredFiles = getFiles();
                                                  });
                                                }
                                              });
                                            },
                                          ),
                                        ],
                                      )),
                                    ),
                                  ]),
                            );
                          }),
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
