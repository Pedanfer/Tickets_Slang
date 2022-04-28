import 'package:exploration_planner/src/functions/utilidades.dart';
import 'package:exploration_planner/src/utils/widgets.dart';
import 'package:exploration_planner/src/views/dashboard.dart';
import 'package:exploration_planner/src/views/login_page.dart';
import 'package:flutter/material.dart';
import '../utils/constants.dart';

class Menu extends StatefulWidget {
  final Widget previousScreen;
  Menu({required this.previousScreen});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  var screen;

  @override
  void initState() {
    screen = widget.previousScreen;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var dimension = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: blue100,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  dimension.width * 0.7,
                  dimension.height * 0.1,
                  dimension.width * 0.05,
                  0,
                ),
                child: IconButton(
                  icon: Transform.scale(
                    scale: 1.5,
                    child: Image.asset(
                      'lib/assets/Rounded Component1.png',
                    ),
                  ),
                  onPressed: () => changePageFade(DashBoard(), context),
                ),
              ),
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
                              spaceLength: 48),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: dimension.height * 0.005,
                    ),
                    TextButton(
                      onPressed: () {},
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
      ),
    );
  }
}
