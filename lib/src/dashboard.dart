import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  
  int paginaActual = 1;
  
  @override
  Widget build(BuildContext context) {
    final dimension = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 178, 204, 226),
            Color.fromARGB(255, 112, 221, 145),
          ],
        )),
        child: Image.asset('lib/assets/ticketRobot.png', scale: 11)
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {
            paginaActual = index;
          });
        },
        currentIndex: paginaActual,
        backgroundColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon:Icon(Icons.photo_camera_back), label: "Galería"),
          BottomNavigationBarItem(icon:Icon(Icons.add_a_photo_sharp), label: "Tomar Foto")
        ],
      ),
    );
  }
}
