import 'dart:io';

import 'package:flutter/services.dart';
import 'package:slang_mobile/src/functions/utilidades.dart';
import 'package:slang_mobile/src/utils/widgets.dart';
import 'package:slang_mobile/src/views/configStorage.dart';
import 'package:slang_mobile/src/views/dashboard.dart';
import 'package:slang_mobile/src/views/editCategs.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/constants.dart';

class Menu extends StatefulWidget {
  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Uri SlangWeb = Uri.parse('https://slang.digital/');
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
                            text: ' Menú',
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
                      ' CONFIGURACIÓN DE ALMACENAMIENTO',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: dimension.height * 0.005,
                  ),
                  TextButton(
                    onPressed: () => changePageFade(editCategs(), context),
                    child: Text(
                      ' EDITAR CATEGORÍAS',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: dimension.height * 0.005,
                  ),
                  TextButton(
                    onPressed: () {
                      launchUrl(SlangWeb);
                    },
                    child: Text(
                      ' IR A SLANG DIGITAL',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: dimension.height * 0.005,
                  ),
                  TextButton(
                    onPressed: () async {
                      /* Ahora mismo elimina los datos del usuario, 
                      deberían estar en la API Rest
                      var prefs = await getPrefs();
                      await prefs!.remove('login');
                      await prefs.remove('driveUserData');
                      signOutDrive();
                      changePageFade(LoginPage(), context);*/
                    },
                    child: Text(
                      ' CAMBIAR DE USUARIO',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: dimension.height * 0.005,
                  ),
                  TextButton(
                    onPressed: () {
                      if (Platform.isAndroid) {
                        SystemNavigator.pop();
                      } else if (Platform.isIOS) {
                        exit(0);
                      }
                    },
                    child: Text(
                      'SALIR',
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
