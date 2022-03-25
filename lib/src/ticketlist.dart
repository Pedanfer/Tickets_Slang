import 'dart:io';

import 'package:exploration_planner/src/utilidades.dart';
import 'package:flutter/material.dart';

class Ticketlist extends StatefulWidget {
  @override
  State<Ticketlist> createState() => TicketlistState();
}

class TicketlistState extends State<Ticketlist> {
  var img = Image.asset('lib/assets/ticketRobot.png', scale: 5);
  List<File> filesList = setFile();
  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder(
        future: getPrefs(),
        builder: (context, snapshot) {
          return Scaffold(
      appBar: AppBar(
        title: Text('Tus tickets'),
        leading: Icon(Icons.logout),
        backgroundColor: Colors.blue,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                setState(() {
                });
              }),
        ],
      ),
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
        child: ListView.builder(
            itemCount: filesList.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: Colors.grey,
                child: ListTile(
                  title: Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(width: 60, height: 60, child: Image.file(filesList[0])),
                      Text(filesList[index].toString().substring(filesList[index].toString().length -21, filesList[index].toString().length-11)),
                      Text(filesList[index].toString().substring(filesList[index].toString().length -10, filesList[index].toString().length-5)),
                    ],
                  )),
                ),
              );
            }),
      ),
    );
  });}
}
