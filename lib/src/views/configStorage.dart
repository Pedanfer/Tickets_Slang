import 'package:slang_mobile/src/functions/Google.dart';
import 'package:slang_mobile/src/functions/utilidades.dart';
import 'package:slang_mobile/src/utils/widgets.dart';
import 'package:slang_mobile/src/views/initialConfig.dart';
import 'package:slang_mobile/src/views/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:slang_mobile/main.dart';
import '../utils/constants.dart';

var option = '';
var driveNameMail;

class ConfigStorage extends StatefulWidget {
  @override
  State<ConfigStorage> createState() => _ConfigStorageState();
}

class _ConfigStorageState extends State<ConfigStorage> {
  @override
  Widget build(BuildContext context) {
    driveNameMail = prefs!.getStringList('driveUserData');
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
            getBackButton(dimension, Menu(), context),
            Padding(
              padding: EdgeInsets.all(dimension.height * 0.01),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      'Actualmente, Slang Tickets está ' +
                          option +
                          ' vinculada a la cuenta:',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      )),
                  TitleWithUnderline(
                      text: ' ' * 80,
                      color: Colors.white,
                      fontSize: 16,
                      spaceLength: 10,
                      dashed: true),
                  SizedBox(height: dimension.height * 0.015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Transform.translate(
                        offset: Offset(-8, 0),
                        child: Transform.scale(
                          scale: 0.9,
                          child: SvgPicture.asset(iconDrive),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            driveNameMail[0],
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                          SizedBox(height: dimension.height * 0.004),
                          Text(
                            driveNameMail[1],
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          )
                        ],
                      ),
                    ],
                  ),
                  TitleWithUnderline(
                      text: ' ' * 80,
                      color: Colors.white,
                      fontSize: 16,
                      spaceLength: 10,
                      dashed: true),
                  SizedBox(height: dimension.height * 0.01),
                  CustomButton(
                    text: 'Desvincular',
                    width: dimension.width * 0.95,
                    height: dimension.height * 0.05,
                    onPressed: () {
                      signOutDrive();
                      changePageFade(InitialConfig(), context);
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
