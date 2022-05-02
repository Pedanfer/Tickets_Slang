import 'package:exploration_planner/src/functions/utilidades.dart';
import 'package:exploration_planner/src/utils/widgets.dart';
import 'package:exploration_planner/src/views/dashboard.dart';
import 'package:exploration_planner/src/views/initialConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/constants.dart';

class ChooseApp extends StatefulWidget {
  @override
  State<ChooseApp> createState() => _ChooseAppState();
}

class _ChooseAppState extends State<ChooseApp> {
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
        child: Padding(
          //To be replaced by the global app bar when implemented
          padding: EdgeInsets.only(
              top: dimension.height * 0.13, bottom: dimension.height * 0.03),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 1.27,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Container(
                      color: Colors.white,
                      height: dimension.height * 0.39,
                      width: dimension.width * 0.9,
                      child: Stack(
                        children: [
                          Text(
                            ' Tickets',
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.w700),
                          ),
                          Transform.translate(
                            offset: Offset(0, 18),
                            child: Transform.scale(
                              scaleX: 0.97,
                              child: SvgPicture.asset(
                                'lib/assets/ticketRectangle.svg',
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () => getPrefs().then((value) => {
                          value!.getStringList('driveUserData') != null
                              ? changePageFade(DashBoard(), context)
                              : changePageFade(InitialConfig(), context)
                        }),
                  ),
                  InkWell(
                    child: Container(
                      color: Colors.white,
                      height: dimension.height * 0.39,
                      width: dimension.width * 0.9,
                      child: Stack(
                        children: [
                          Text(
                            ' Reporte de tiempos',
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.w700),
                          ),
                          Transform.translate(
                            offset: Offset(0, 18),
                            child: Transform.scale(
                              scaleX: 0.97,
                              child: SvgPicture.asset(
                                'lib/assets/timeRectangle.svg',
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                      child: Container(
                        color: Colors.white,
                        height: dimension.height * 0.39,
                        width: dimension.width * 0.9,
                        child: Stack(
                          children: [
                            Text(
                              ' La Roboteka',
                              style: TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.w700),
                            ),
                            Transform.translate(
                              offset: Offset(0, 18),
                              child: Transform.scale(
                                scaleX: 0.97,
                                child: SvgPicture.asset(
                                  'lib/assets/robotekaRectangle.svg',
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      //Change this to the initial screen of the time app
                      onTap: () {})
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
