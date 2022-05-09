import 'package:flutter_svg/flutter_svg.dart';
import 'package:slang_mobile/src/functions/utilidades.dart';
import 'package:slang_mobile/src/views/addPhoto.dart';
import 'package:slang_mobile/src/views/menu.dart';
import 'package:slang_mobile/src/views/ticketlist.dart';
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
          icon: SvgPicture.asset('lib/assets/icons/Burger_Menu.svg'),
          onPressed: () => changePageFade(Menu(), context),
        ),
        title: Container(
            padding: EdgeInsets.fromLTRB(60, 30, 60, 30),
            child: Image.asset(
                'lib/assets/Slang/Logo_slang_horizontalblanco.png')),
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
              icon: (paginaActual == 0)
                  ? SvgPicture.asset(
                      'lib/assets/icons/Selected_NuevoTicket.svg',
                      height: 52,
                      width: 64,
                    )
                  : SvgPicture.asset(
                      'lib/assets/icons/NuevoTicket.svg',
                      height: 52,
                      width: 64,
                    ),
              label: 'Nuevo ticket'),
          BottomNavigationBarItem(
            icon: (paginaActual == 1)
                ? SvgPicture.asset(
                    'lib/assets/icons/Selected_Archivador.svg',
                    height: 52,
                    width: 64,
                  )
                : SvgPicture.asset(
                    'lib/assets/icons/Archivador.svg',
                    height: 52,
                    width: 64,
                  ),
            label: 'Archivador',
          )
        ],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 6,
      ),
    );
  }
}
