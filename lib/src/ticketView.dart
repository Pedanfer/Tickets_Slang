import 'dart:io';

import 'package:exploration_planner/src/utilidades.dart';
import 'package:flutter/material.dart';

class TicketView extends StatefulWidget {
  @override
  State<TicketView> createState() => TicketViewState();
}

class TicketViewState extends State<TicketView> {
  var img = Image.asset('lib/assets/ticketRobot.png', scale: 5);
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: 
      Container(
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
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Container(
              child: Image.asset( 'lib/assets/ticketRobot.png'),
              ),
            Container(
              child: ButtonBar(),
            ),
          ]
        )
      ),
    );
  }
}
