import 'package:slang_mobile/src/tickets/functions/utilidades.dart';
import 'package:slang_mobile/src/tickets/utils/widgets.dart';
import 'package:slang_mobile/src/tickets/views/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../functions/Google.dart' as Google;
import '../utils/constants.dart';

GlobalKey<CustomCheckBoxState> checkBoxKey = GlobalKey();

class InitialConfig extends StatefulWidget {
  @override
  State<InitialConfig> createState() => _InitialConfigState();
}

var buttonVisible = false;
var saveUser = false;

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
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: dimension.width * 0.035,
                      right: dimension.width * 0.035,
                      top: dimension.height * 0.01),
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
                                        style: TextStyle(
                                            fontWeight: FontWeight.w200)),
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
                            Text(
                              'Para comenzar a usar la aplicación necesitarás seleccionar dónde almacenar los tickets:',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white,
                                  fontSize: 14.5),
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
                                  height:
                                      dimension.height * (0.023 + separator)),
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
                                  onPressed: () {},
                                  icon: SvgPicture.asset(
                                    dropBoxIcon,
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height:
                                      dimension.height * (0.023 + separator)),
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
                              /* Quizás útil para DropBox en el futuro 
                                TextFormField(
                                keyboardType: TextInputType.name,
                                autocorrect: false,
                                onChanged: (value) =>
                                    {driveUserData[0] = value},
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
                                  errorStyle:
                                      TextStyle(fontSize: 10, height: 1),
                                ),
                              ),
                              SizedBox(
                                height: dimension.height * (0.02 + separator),
                              ),
                              TextFormField(
                                keyboardType: TextInputType.name,
                                autocorrect: false,
                                onChanged: (value) =>
                                    {driveUserData[1] = value},
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
                                  errorStyle:
                                      TextStyle(fontSize: 10, height: 1),
                                ),
                              ),*/
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  elevation: 1.0,
                                  fixedSize: Size(dimension.width * 0.5,
                                      dimension.height * 0.03),
                                ),
                                onPressed: () {},
                                child: InkWell(
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
                                  ),
                                  onTap: () {
                                    saveUser =
                                        checkBoxKey.currentState!.checked;
                                    Google.signInDrive();
                                    Future.delayed(const Duration(seconds: 4),
                                        () {
                                      setState(() {
                                        buttonVisible = true;
                                      });
                                    });
                                  },
                                ),
                              ),
                              TitleWithUnderline(
                                  color: Colors.white,
                                  text: '',
                                  fontSize: 16,
                                  spaceLength: 85,
                                  dashed: true),
                              TitleWithUnderline(
                                  color: Colors.transparent,
                                  text: '',
                                  fontSize: 16,
                                  spaceLength: 1,
                                  dashed: false),
                              Transform.translate(
                                offset: Offset(
                                    0, -20 * (dimension.height * 0.0015)),
                                child: Column(
                                  children: [
                                    CustomCheckBox(
                                        color: Colors.white,
                                        dimension: dimension,
                                        offsetCheck: -36,
                                        offsetText: -18,
                                        key: checkBoxKey,
                                        text: [
                                          TextSpan(text: 'Mantenerme logueado')
                                        ]),
                                    Visibility(
                                      visible: buttonVisible,
                                      child: CustomButton(
                                        text: 'Continuar',
                                        width: dimension.width * 0.9,
                                        height: dimension.width * 0.11,
                                        onPressed: () => {
                                          changePageFade(DashBoard(), context)
                                        },
                                      ),
                                    )
                                  ],
                                ),
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
          ],
        ),
      ),
    );
  }
}
