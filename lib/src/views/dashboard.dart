import 'package:exploration_planner/src/utils/constants.dart';
import 'package:exploration_planner/src/views/addPhoto.dart';
import 'package:exploration_planner/src/views/ticketlist.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int paginaActual = 0;

  List<Widget> paginas = [
    AddPhoto(),
    Ticketlist(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: paginas[paginaActual],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: blue100,
        onTap: (index) {
          setState(() {
            paginaActual = index;
          });
        },
        currentIndex: paginaActual,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Nuevo ticket'),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder_open_outlined),
            label: 'Archivador',
          )
        ],
        selectedLabelStyle: TextStyle(fontSize: 12, color: Colors.white),
        unselectedLabelStyle: TextStyle(fontSize: 12, color: Color.fromARGB(255, 177, 177, 177)),
        unselectedItemColor: Color.fromARGB(255, 177, 177, 177),
        selectedItemColor: Colors.white,
      ),
    );
  }
}
