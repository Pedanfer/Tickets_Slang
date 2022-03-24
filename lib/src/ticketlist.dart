import 'package:flutter/material.dart';

class Ticketlist extends StatefulWidget {
  @override
  State<Ticketlist> createState() => TicketlistState();
}

class TicketlistState extends State<Ticketlist> {
  int paginaActual = 0;
  bool isVisibleBorrarAceptar = false;
  bool isVisibleFotoGaleria = true;
  bool isVisibleCategorias = false;

  var img = Image.asset('lib/assets/ticketRobot.png', scale: 11);
  String vista = 'Seleccione categoría';
  String vista2 = 'Seleccione categoría';

  @override
  Widget build(BuildContext context) {
    final dimension = MediaQuery.of(context).size;
    List<String> lista_de_nombres = <String>[
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
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 2, 137, 248),
              Color.fromARGB(255, 0, 15, 5),
            ],
          ),
        ),
        child:ListView.builder(
            itemCount: lista_de_nombres.length,
            itemBuilder: (BuildContext context, int index){
              return Card(
                color: Colors.red,
                child: ListTile(
                  title: Text(lista_de_nombres[index]),
                )
              );
            }
          ),

/*ç

      child: Scrollbar(
        isAlwaysShown: true,
        showTrackOnHover: true,
        child: ListView.builder(itemBuilder: (c, i) => MyItem(i), itemCount: 20,),)*/

        );
  }
}
