import 'package:exploration_planner/src/functions/communications.dart';
import 'package:exploration_planner/src/functions/utilidades.dart';
import 'package:exploration_planner/src/utils/constants.dart';
import 'package:exploration_planner/src/views/login_page.dart';
import 'package:exploration_planner/src/utils/validators.dart' as validators;
import 'package:exploration_planner/src/utils/widgets.dart';
import 'package:exploration_planner/src/views/termsService.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var dimension;
bool isVisibleRegister = false;
GlobalKey<CustomCheckBoxState> checkBoxKey = GlobalKey();

class UserRegister extends StatefulWidget {
  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  bool loginOK = false;
  var email;
  var password;
  var name;
  final _formKey = GlobalKey<FormState>();
  bool isRobotVisible = false;
  bool areButtonsVisible = false;
  var adaptHeight;

  @override
  Widget build(BuildContext context) {
    var separator = 0.01;
    dimension = MediaQuery.of(context).size;
    if (MediaQuery.of(context).viewInsets.bottom == 0) {
      isRobotVisible = true;
      areButtonsVisible = true;
      adaptHeight = 0.8;
    } else {
      isRobotVisible = false;
      areButtonsVisible = false;
      adaptHeight = 0.58;
    }
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xff011A58),
              Color(0xffECEEF3),
            ],
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: dimension.height * 0.05),
              Visibility(
                  visible: isRobotVisible,
                  child: Image.asset('lib/assets/Logo_slang_horiz.png',
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
                          text: 'Regístrate', fontSize: 24, spaceLength: 32),
                      SizedBox(height: dimension.height * separator),
                      RichText(
                        text: TextSpan(
                          // Note: Styles for TextSpans must be explicitly defined.
                          // Child text spans will inherit styles from parent
                          style: TextStyle(
                            fontSize: 14.0,
                            color: blue100,
                          ),
                          children: <TextSpan>[
                            new TextSpan(
                                text:
                                    'Para formar parte de SLANG debes completar '),
                            new TextSpan(
                                text: 'los siguientes campos ',
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold)),
                            new TextSpan(text: '¡Vamos con ellos!'),
                          ],
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
                          autocorrect: false,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          onChanged: (value) => name = value,
                        ),
                      ),
                      SizedBox(height: dimension.height * separator),
                      TextFormField(
                        validator: validators.validateEmail,
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        onChanged: (value) => setState(() => {email = value}),
                      ),
                      SizedBox(height: dimension.height * separator),
                      TextFormField(
                        validator: validators.validateCreatedPassword,
                        onChanged: (value) => password = value,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        autocorrect: false,
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        autocorrect: false,
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
                                key: checkBoxKey,
                                dimension: dimension,
                                offsetCheck: -36,
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
                                                        name, email, password)
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
