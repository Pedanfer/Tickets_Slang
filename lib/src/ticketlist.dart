// ignore_for_file: unused_local_variable, omit_local_variable_types

import 'dart:io';
import 'package:exploration_planner/src/login_page.dart';
import 'package:exploration_planner/src/ticketView.dart';
import 'package:exploration_planner/src/utilidades.dart';
import 'package:flutter/material.dart';

class Ticketlist extends StatefulWidget {
  @override
  State<Ticketlist> createState() => TicketlistState();
}

var textoInicio = 'Fecha inicio';
var textoFin = 'Fecha fin';
var newDateRange;
var end;

class TicketlistState extends State<Ticketlist> {
  final controller = TextEditingController();
  var img = Image.asset('lib/assets/ticketRobot.png', scale: 5);
  var unfilteredFiles;
  var filteredFiles = getFiles();
  DateTimeRange dateRange =
      DateTimeRange(start: DateTime(2022, 03, 28), end: DateTime(2025, 03, 28));

  @override
  Widget build(BuildContext context) {
    unfilteredFiles = getFiles();
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
                          child: Text(textoInicio),
                        )),
                        Expanded(
                            child: ElevatedButton(
                          onPressed: pickDateRange,
                          child: Text(textoFin),
                        ))
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: filteredFiles.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              color: Colors.grey,
                              child: ListTile(
                                title: Container(
                                    child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        width: 60,
                                        height: 60,
                                        child:
                                            Image.file(filteredFiles[index])),
                                    Text(filteredFiles[index]
                                        .toString()
                                        .substring(78, 88)),
                                    Text(filteredFiles[index]
                                        .toString()
                                        .substring(89, 94)),
                                  ],
                                )),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (c, a1, a2) => TicketView(),
                                      transitionsBuilder:
                                          (c, anim, a2, child) =>
                                              FadeTransition(
                                                  opacity: anim, child: child),
                                      transitionDuration:
                                          Duration(milliseconds: 700),
                                    ),
                                  );
                                },
                              ),
                            );
                          }),
                    ),
                  ],
                )),
          );
        });
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        initialDateRange: dateRange,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (newDateRange == null) return;

    setState(() {
      var digitMonth1 = newDateRange.start.month < 10 ? 0 : '';
      var digitMonth2 = newDateRange.end.month < 10 ? 0 : '';
      var digitDay1 = newDateRange.start.day < 10 ? 0 : '';
      var digitDay2 = newDateRange.end.day < 10 ? 0 : '';
      textoInicio =
          '${newDateRange.start.year}-$digitMonth1${newDateRange.start.month}-$digitDay1${newDateRange.start.day}';
      textoFin =
          '${newDateRange.end.year}-$digitMonth2${newDateRange.end.month}-$digitDay2${newDateRange.end.day}';
      filteredFiles = unfilteredFiles
          .where((file) =>
              (DateTime.parse(file.toString().substring(78, 88))
                      .isAfter(DateTime.parse(textoInicio)) ||
                  DateTime.parse(file.toString().substring(78, 88))
                      .isAtSameMomentAs(DateTime.parse(textoInicio))) &&
              (DateTime.parse(file.toString().substring(78, 88))
                      .isBefore(DateTime.parse(textoFin)) ||
                  DateTime.parse(file.toString().substring(78, 88))
                      .isAtSameMomentAs(DateTime.parse(textoFin))))
          .toList();
    });
  }
}
