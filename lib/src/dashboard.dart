import 'package:exploration_planner/src/addPhoto.dart';
import 'package:exploration_planner/src/ticketlist.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int paginaActual = 1;

  List<Widget> paginas = [
    AddPhoto(),
    Ticketlist(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: paginas[paginaActual],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff011A58),
        onTap: (index) {
          setState(() {
            paginaActual = index;
          });
        },
        currentIndex: paginaActual,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'AÑADIR'),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder_open_outlined),
            label: 'CATEGORIAS',
          )
        ],
        showUnselectedLabels: false,
      ),
    );
  }
}
