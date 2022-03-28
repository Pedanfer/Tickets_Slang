import 'dart:io';

import 'package:exploration_planner/src/dashboard.dart';
import 'package:exploration_planner/src/utilidades.dart';
import 'package:flutter/material.dart';

class TicketView extends StatefulWidget {
  @override
  State<TicketView> createState() => TicketViewState();
}

class TicketViewState extends State<TicketView> {
  var imgprueba = Image.asset('lib/assets/ticketRobot.png', scale: 5);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(255, 255, 0, 128),
                Color.fromARGB(255, 72, 221, 2),
              ],
            ),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(imgprueba.toString().substring(0, 40)),
                    Container(
                      child: IconButton(
                        icon: Icon(Icons.edit_note),
                        iconSize: 60,
                        onPressed: () {
                          setState(() {
                            imgprueba = Image.asset('lib/assets/okRobot.png');
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('CATEGORIA 1: ' +
                        imgprueba.toString().substring(40, 80)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('CATEGORIA 2: ' +
                        imgprueba.toString().substring(80, 120)),
                  ],
                ),
                imgprueba,
              ])),
    );
  }
}
