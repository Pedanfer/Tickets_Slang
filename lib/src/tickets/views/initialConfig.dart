import 'package:exploration_planner/src/tickets/functions/utilidades.dart';
import 'package:exploration_planner/src/tickets/utils/widgets.dart';
import 'package:exploration_planner/src/tickets/views/configStorage.dart';
import 'package:exploration_planner/src/tickets/views/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/constants.dart';

GlobalKey<CustomCheckBoxState> checkBoxKey = GlobalKey();

class InitialConfig extends StatefulWidget {
  @override
  State<InitialConfig> createState() => _InitialConfigState();
}

class _InitialConfigState extends State<InitialConfig> {
  var driveFormsVisible = false;
  var isImgVisible = true;
  var areIconsVisible = true;
  var boxHeight = 0.03;
  double separator = 0;
  @override
  Widget build(BuildContext context) {
    var dimension = MediaQuery.of(context).size;
    if (MediaQuery.of(context).viewInsets.bottom == 0) {
      separator = 0;
      isImgVisible = true;
    } else {
      separator = 0.01;
      isImgVisible = false;
    }
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: blue100,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: dimension.width * 0.035,
                  right: dimension.width * 0.035,
                  top: dimension.height * 0.06),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Visibility(
                    visible: isImgVisible,
                    child: Column(
                      children: [
                        Transform.translate(
                          offset: Offset(3, -3),
                          child: RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 24.0),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Bienvenido/a a la ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w200)),
                                TextSpan(
                                  text: 'aplicación de tickets de Slang',
                                )
                              ],
                            ),
                          ),
                        ),
                        //Con este Widget podemos recortar imágenes
                        AspectRatio(
                          aspectRatio: 1.4,
                          child: SvgPicture.asset(
                            'lib/assets/ticketRectangle.svg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: dimension.height * 0.01),
                  Visibility(
                    visible: areIconsVisible,
                    child: Column(
                      children: [
                        Transform(
                          transform: Matrix4.identity()..scale(1.1, 1.3),
                          child: Text(
                            'Para comenzar a usar la aplicación necesitarás seleccionar dónde almacenar los tickets:',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontWeight: FontWeight.w200,
                                color: Colors.white,
                                fontSize: 14.0),
                          ),
                        ),
                        SizedBox(height: dimension.height * 0.01),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: dimension.height * (boxHeight + separator),
                  ),
                  Row(
                    children: [
                      SizedBox(width: dimension.width * 0.02),
                      Column(
                        children: [
                          SizedBox(width: dimension.width * 0.1),
                          Transform.scale(
                            scale: 2,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  boxHeight = 0.02;
                                  driveFormsVisible = true;
                                  areIconsVisible = false;
                                });
                              },
                              icon: SvgPicture.asset(
                                iconDrive,
                              ),
                            ),
                          ),
                          SizedBox(
                              height: dimension.height * (0.023 + separator)),
                          Text(
                            'Google Drive',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      SizedBox(width: dimension.width * 0.1),
                      Column(
                        children: [
                          Transform.scale(
                            scale: 2,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  boxHeight = 0.03;
                                  driveFormsVisible = false;
                                  areIconsVisible = true;
                                });
                              },
                              icon: SvgPicture.asset(
                                dropBoxIcon,
                              ),
                            ),
                          ),
                          SizedBox(
                              height: dimension.height * (0.023 + separator)),
                          Text(
                            'Dropbox',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                  Visibility(
                    visible: driveFormsVisible,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: dimension.width * 0.01),
                      child: Column(
                        children: [
                          TitleWithUnderline(
                              color: Colors.white,
                              text: '',
                              fontSize: 16,
                              spaceLength: 85,
                              dashed: true),
                          SizedBox(
                            height: dimension.height * (0.02 + separator),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            autocorrect: false,
                            onChanged: (value) => {driveUserData[0] = value},
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'Nombre de usuario',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none),
                              contentPadding:
                                  EdgeInsets.all(dimension.width * 0.024),
                              filled: true,
                              fillColor: formBackground,
                              errorStyle: TextStyle(fontSize: 10, height: 1),
                            ),
                          ),
                          SizedBox(
                            height: dimension.height * (0.02 + separator),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            autocorrect: false,
                            onChanged: (value) => {driveUserData[1] = value},
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'Email de usuario',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none),
                              contentPadding:
                                  EdgeInsets.all(dimension.width * 0.024),
                              filled: true,
                              fillColor: formBackground,
                              errorStyle: TextStyle(fontSize: 10, height: 1),
                            ),
                          ),
                          CustomCheckBox(
                              color: Colors.white,
                              dimension: dimension,
                              offsetCheck: -36,
                              offsetText: -18,
                              key: checkBoxKey,
                              text: [
                                TextSpan(text: 'Deseo guardar estos datos')
                              ]),
                          Transform.translate(
                            offset: const Offset(4.0, -15.0),
                            child: Row(
                              children: [
                                TitleWithUnderline(
                                    text: ' ',
                                    color: Colors.white,
                                    fontSize: 16,
                                    spaceLength: 36,
                                    dashed: false),
                                Transform.translate(
                                  offset: const Offset(0, 6),
                                  child: Text('    OR    ',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12)),
                                ),
                                TitleWithUnderline(
                                    text: ' ',
                                    color: Colors.white,
                                    fontSize: 16,
                                    spaceLength: 36,
                                    dashed: false),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: dimension.height * separator,
                          ),
                          Transform.translate(
                            offset: const Offset(0, -10),
                            child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  elevation: 1.0,
                                  fixedSize: Size(dimension.width * 0.5,
                                      dimension.height * 0.03),
                                ),
                                onPressed: () {},
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                        'lib/assets/googleLogo.svg'),
                                    SizedBox(width: dimension.width * 0.015),
                                    Text(
                                      'Sign in with Google',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: dimension.height * (0.005 + separator),
                          ),
                          Transform.translate(
                            offset: const Offset(0, -10),
                            child: CustomButton(
                                text: 'Vincular',
                                width: dimension.width * 0.9,
                                height: dimension.width * 0.11,
                                onPressed: () => {
                                      getPrefs().then((value) => {
                                            if (checkBoxKey
                                                .currentState!.checked)
                                              {
                                                value!.setStringList(
                                                    'driveUserData',
                                                    driveUserData)
                                              }
                                          }),
                                      changePageFade(DashBoard(), context)
                                    }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
