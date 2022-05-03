import 'package:exploration_planner/src/tickets/functions/utilidades.dart';
import 'package:exploration_planner/src/tickets/views/addPhoto.dart';
import 'package:exploration_planner/src/tickets/views/menu.dart';
import 'package:exploration_planner/src/tickets/views/ticketlist.dart';
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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => changePageFade(Menu(), context),
        ),
        title: Container(
            padding: EdgeInsets.fromLTRB(60, 30, 60, 30),
            child: Image.asset('lib/assets/Logo_slang_horizontalblanco.png')),
        actions: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.person)),
        ],
        backgroundColor: Color(0xFF011A58),
      ),
      body: paginas[paginaActual],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF011A58),
        onTap: (index) {
          setState(() {
            paginaActual = index;
          });
        },
        currentIndex: paginaActual,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long), label: 'Nuevo ticket'),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder_open_outlined),
            label: 'Archivador',
          )
        ],
        selectedLabelStyle: TextStyle(fontSize: 12, color: Colors.white),
        unselectedLabelStyle: TextStyle(fontSize: 12, color: Colors.white),
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
      ),
    );
  }
}
