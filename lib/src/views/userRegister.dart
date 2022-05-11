import 'package:flutter_svg/flutter_svg.dart';
import 'package:slang_mobile/src/functions/communications.dart';
import 'package:slang_mobile/src/functions/utilidades.dart';
import 'package:slang_mobile/src/utils/constants.dart';
import 'package:slang_mobile/src/views/loginpage.dart';
import 'package:slang_mobile/src/utils/validators.dart' as validators;
import 'package:slang_mobile/src/utils/widgets.dart';
import 'package:slang_mobile/src/views/termsService.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var dimension;
var userData = ['', '', '', ''];
bool isVisibleRegister = false;
GlobalKey<CustomCheckBoxState> checkBoxKey = GlobalKey();

class UserRegister extends StatefulWidget {
  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  bool loginOK = false;
  final _formKey = GlobalKey<FormState>();
  bool isRobotVisible = false;
  bool isMessageVisible = true;
  bool areButtonsVisible = false;
  var adaptHeight;

  @override
  Widget build(BuildContext context) {
    print(userData[0]);
    var separator = 0.01;
    dimension = MediaQuery.of(context).size;
    if (MediaQuery.of(context).viewInsets.bottom == 0) {
      isMessageVisible = true;
      isRobotVisible = true;
      areButtonsVisible = true;
      adaptHeight = 0.8;
    } else {
      if (!_formKey.currentState!.validate()) {
        isMessageVisible = false;
      }
      isRobotVisible = false;
      areButtonsVisible = false;
      adaptHeight = 0.58;
    }
    return Scaffold(
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/assets/backgrounds/fondo.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: dimension.height * 0.05),
              Visibility(
                  visible: isRobotVisible,
                  child: SvgPicture.asset('lib/assets/Slang/IconHorizontal.svg',
                      width: dimension.width * 0.55)),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.white,
                ),
                height: dimension.height * adaptHeight,
                margin: EdgeInsets.symmetric(
                    horizontal: dimension.width * 0.05,
                    vertical: dimension.height * 0.01),
                padding: EdgeInsets.symmetric(
                    horizontal: dimension.width * 0.05,
                    vertical: dimension.height * 0.02),
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: dimension.height * separator),
                      TitleWithUnderline(
                          color: blue100,
                          text: 'Regístrate',
                          fontSize: 24,
                          spaceLength: 32,
                          dashed: false),
                      SizedBox(height: dimension.height * separator),
                      Visibility(
                        visible: isMessageVisible,
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 16.0,
                              color: blue100,
                            ),
                            children: <TextSpan>[
                              new TextSpan(
                                  text:
                                      'Para formar parte de SLANG debes completar '),
                              new TextSpan(
                                  text: 'los siguientes campos ',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold)),
                              new TextSpan(text: '¡Vamos con ellos!'),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: dimension.height * separator),
                      Text(
                        '*Campos obligatorios' + ' ' * 46,
                        style: TextStyle(color: blue100),
                      ),
                      SizedBox(height: dimension.height * separator),
                      Padding(
                        padding:
                            EdgeInsets.only(right: dimension.width * 0.001),
                        child: TextFormField(
                          validator: validators.validateName,
                          keyboardType: TextInputType.name,
                          initialValue: userData[0],
                          autocorrect: false,
                          onChanged: (value) => {userData[0] = value},
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: 'Nombre de Usuario',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none),
                            contentPadding:
                                EdgeInsets.all(dimension.width * 0.015),
                            filled: true,
                            fillColor: formBackground,
                            errorStyle: TextStyle(fontSize: 10, height: 1),
                          ),
                        ),
                      ),
                      SizedBox(height: dimension.height * separator),
                      TextFormField(
                        validator: validators.validateEmail,
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        initialValue: userData[1],
                        onChanged: (value) => {userData[1] = value},
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: '*Email',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none),
                          contentPadding:
                              EdgeInsets.all(dimension.width * 0.015),
                          filled: true,
                          fillColor: formBackground,
                          errorStyle: TextStyle(fontSize: 10, height: 1),
                          hintText: 'ejemplo@mail.com',
                        ),
                      ),
                      SizedBox(height: dimension.height * separator),
                      TextFormField(
                        validator: validators.validateCreatedPassword,
                        autocorrect: false,
                        initialValue: userData[2],
                        onChanged: (value) => {userData[2] = value},
                        decoration: InputDecoration(
                          labelText: '*Contraseña',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none),
                          contentPadding:
                              EdgeInsets.all(dimension.width * 0.01),
                          filled: true,
                          fillColor: formBackground,
                          errorMaxLines: 3,
                          errorStyle: TextStyle(fontSize: 10, height: 1),
                        ),
                      ),
                      SizedBox(height: dimension.height * separator),
                      TextFormField(
                        validator: validators.validateCreatedPassword,
                        autocorrect: false,
                        onChanged: (value) => {userData[3] = value},
                        decoration: InputDecoration(
                          labelText: '*Confirma la contraseña',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none),
                          contentPadding:
                              EdgeInsets.all(dimension.width * 0.015),
                          filled: true,
                          fillColor: formBackground,
                          errorMaxLines: 3,
                          errorStyle: TextStyle(fontSize: 10, height: 1),
                        ),
                      ),
                      SizedBox(height: dimension.height * separator),
                      Visibility(
                          visible: areButtonsVisible,
                          child: Column(
                            children: [
                              CustomCheckBox(
                                color: blue100,
                                key: checkBoxKey,
                                dimension: dimension,
                                offsetCheck: -10,
                                offsetText: -20,
                                text: [
                                  TextSpan(
                                    text: 'He leído y acepto la ',
                                  ),
                                  TextSpan(
                                    text: 'Política de privacidad.',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        changePageFade(TermsService(), context);
                                      },
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                        decorationThickness: 1.5),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: pink100,
                                              width: 1,
                                              style: BorderStyle.solid),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        backgroundColor: Colors.white,
                                        elevation: 1.0,
                                        minimumSize: Size(dimension.width * 0.4,
                                            dimension.height * 0.065),
                                      ),
                                      onPressed: () {
                                        userData = ['', '', '', ''];
                                        changePageFade(LoginPage(), context);
                                      },
                                      child: Text('Volver',
                                          style: GoogleFonts.ibmPlexSans(
                                              fontSize: 16,
                                              color: pink100,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  SizedBox(width: dimension.width * 0.02),
                                  Expanded(
                                    child: CustomButton(
                                      text: 'Regístrate',
                                      width: dimension.width * 0.4,
                                      height: dimension.height * 0.065,
                                      onPressed: () => {
                                        if (checkBoxKey.currentState!.checked)
                                          {
                                            if (_formKey.currentState!
                                                .validate())
                                              {
                                                registerSlang(
                                                        userData[0],
                                                        userData[1],
                                                        userData[2])
                                                    .then(
                                                  (connection) => {
                                                    if (connection)
                                                      {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          backgroundColor:
                                                              Color(0xff011A58),
                                                          content: Text(
                                                              'Complete el registro en su correo, por favor.\nNo podrá utilizar Slang hasta entonces.',
                                                              style: TextStyle(
                                                                  fontSize: 14),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center),
                                                          duration: Duration(
                                                              seconds: 6),
                                                        )),
                                                        setState(() =>
                                                            {loginOK = true}),
                                                        Future.delayed(
                                                          Duration(
                                                              milliseconds:
                                                                  5500),
                                                          () => {
                                                            changePageFade(
                                                                LoginPage(),
                                                                context)
                                                          },
                                                        ),
                                                      }
                                                  },
                                                )
                                              }
                                            else
                                              {
                                                setState(() {
                                                  separator = 0.005;
                                                  customSnackBar(
                                                      context,
                                                      'Hay campos sin rellenar o con formato erróneo',
                                                      2);
                                                  isMessageVisible = false;
                                                })
                                              }
                                          }
                                        else
                                          {
                                            setState(() {
                                              customSnackBar(
                                                  context,
                                                  'No has aceptado las condiciones de privacidad.',
                                                  2);
                                            })
                                          }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
