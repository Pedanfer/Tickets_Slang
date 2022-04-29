import 'package:exploration_planner/src/functions/utilidades.dart';
import 'package:exploration_planner/src/utils/widgets.dart';
import 'package:exploration_planner/src/views/configStorage.dart';
import 'package:exploration_planner/src/views/dashboard.dart';
import 'package:exploration_planner/src/views/login_page.dart';
import 'package:flutter/material.dart';
import '../utils/constants.dart';

class Menu extends StatefulWidget {
  /*todo: get back to previous screen from menu
  final Widget previousScreen;
  Menu({required this.previousScreen});*/

  @override
  State<Menu> createState() => _MenuState();
}

var driveUserData = ['Ramon Gómez Ruiz', 'ramon.gomez@slanginnovations.com'];

class _MenuState extends State<Menu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var dimension = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: blue100,
        ),
        child: Column(
          children: [
            getBackButton(dimension, DashBoard(), context),
            Padding(
              padding: EdgeInsets.only(right: dimension.width * 0.2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: dimension.height * 0.25,
                  ),
                  Row(
                    children: [
                      SizedBox(width: dimension.width * 0.02),
                      Expanded(
                        child: TitleWithUnderline(
                            color: Colors.white,
                            text: 'Menú',
                            fontSize: 24,
                            spaceLength: 48,
                            dashed: false),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: dimension.height * 0.005,
                  ),
                  TextButton(
                    onPressed: () => changePageFade(ConfigStorage(), context),
                    child: Text(
                      'CONFIGURACIÓN DE ALMACENAMIENTO',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: dimension.height * 0.005,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'EDITAR CATEGORÍAS',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: dimension.height * 0.005,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'IR A SLANG DIGITAL',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: dimension.height * 0.005,
                  ),
                  TextButton(
                    onPressed: () async {
                      var prefs = await getPrefs();
                      await prefs!.remove('login');
                      changePageFade(LoginPage(), context);
                    },
                    child: Text(
                      'CERRAR SESIÓN',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
