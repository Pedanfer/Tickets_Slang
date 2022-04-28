import 'dart:html';

import 'package:exploration_planner/src/functions/utilidades.dart';
import 'package:exploration_planner/src/utils/widgets.dart';
import 'package:exploration_planner/src/views/dashboard.dart';
import 'package:exploration_planner/src/views/userRegister.dart';
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
    dimension = MediaQuery.of(context).size;
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
              Text('hey'),
              Column(
                children: [
                  TitleWithUnderline(
                      text: 'Menú', fontSize: 24, spaceLength: 24)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
