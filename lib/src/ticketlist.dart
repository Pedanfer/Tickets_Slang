import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Ticketlist extends StatefulWidget {
  @override
  State<Ticketlist> createState() => TicketlistState();
}

class TicketlistState extends State<Ticketlist> {
  var img = Image.asset('lib/assets/ticketRobot.png', scale: 5);
  @override
  Widget build(BuildContext context) {
    var directory = () async => await getExternalStorageDirectory();
    var lista_de_nombres = <String>[
      'Hola',
      'adios',
      'otro hola',
      'otro adios',
      'nos vemos mañana',
      'pero solo si madrugas',
      'Hola',
      'adios',
      'otro hola',
      'otro adios',
      'nos vemos mañana',
      'pero solo si madrugas',
      'Hola',
      'adios',
      'otro hola',
      'otro adios',
      'nos vemos mañana',
      'pero solo si madrugas',
    ];
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
                  lista_de_nombres[1] = 'CONSEGUIDO';
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
            itemCount: lista_de_nombres.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: Colors.grey,
                child: ListTile(
                  title: Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(width: 60, height: 60, child: img),
                      Text(lista_de_nombres[index]),
                    ],
                  )),
                ),
              );
            }),
      ),
    );
  }
}
