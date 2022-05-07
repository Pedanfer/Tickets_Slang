import 'dart:async';

import 'package:slang_mobile/src/tickets/functions/communications.dart';
import 'package:slang_mobile/src/tickets/functions/utilidades.dart';
import 'package:slang_mobile/src/tickets/utils/constants.dart';
import 'package:slang_mobile/src/tickets/views/chooseApp.dart';
import 'package:slang_mobile/src/tickets/views/userRegister.dart';
import 'package:slang_mobile/src/tickets/utils/validators.dart' as validators;
import 'package:slang_mobile/src/tickets/utils/widgets.dart';
import 'package:flutter/material.dart';

var dimension;
bool isVisibleRegister = false;
GlobalKey<CustomCheckBoxState> checkBoxKey = GlobalKey();

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isTitleVisible = true;
  bool loginOK = false;
  var boxHeight;
  var email;
  var password;
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    dimension = MediaQuery.of(context).size;
    var robotWelcome;
    if (MediaQuery.of(context).viewInsets.bottom == 0) {
      robotWelcome = Image.asset('lib/assets/Slang/Logo_slang_horiz.png',
          width: dimension.width * 0.55);
      isTitleVisible = true;
      boxHeight = 0.54;
    } else {
      robotWelcome = SizedBox();
      isTitleVisible = false;
      boxHeight = 0.47;
    }
    return Scaffold(
      body: Form(
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
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            robotWelcome,
            SizedBox(height: dimension.height * 0.015),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.white,
              ),
              height: dimension.height * boxHeight,
              margin: EdgeInsets.symmetric(
                  horizontal: dimension.width * 0.05,
                  vertical: dimension.width * 0.05),
              padding: EdgeInsets.only(
                  bottom: dimension.height * 0.01,
                  top: dimension.height * 0.03,
                  right: dimension.width * 0.04,
                  left: dimension.width * 0.04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: isTitleVisible,
                    child: TitleWithUnderline(
                        color: blue100,
                        text: 'Login',
                        fontSize: 24,
                        spaceLength: 40,
                        dashed: false),
                  ),
                  SizedBox(height: dimension.height * 0.015),
                  TextFormField(
                    validator: validators.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none),
                        contentPadding: EdgeInsets.all(dimension.width * 0.015),
                        filled: true,
                        fillColor: formBackground,
                        errorStyle: TextStyle(fontSize: 10, height: 1),
                        icon: Icon(
                          Icons.mail_outline_rounded,
                          color: blue100,
                        ),
                        hintText: 'ejemplo@mail.com',
                        labelText: 'Email'),
                    onChanged: (value) => setState(() => {email = value}),
                  ),
                  SizedBox(height: dimension.height * 0.01),
                  TextFormField(
                    validator: validators.validatePassword,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    autocorrect: false,
                    obscureText: !_showPassword ? true : false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none),
                        contentPadding: EdgeInsets.all(dimension.width * 0.015),
                        filled: true,
                        fillColor: formBackground,
                        errorMaxLines: 3,
                        errorStyle: TextStyle(fontSize: 10, height: 1),
                        suffixIcon: InkWell(
                            onTap: () => setState(() {
                                  _showPassword = !_showPassword;
                                }),
                            child: _showPassword
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off)),
                        icon: Icon(
                          Icons.lock,
                          color: blue100,
                        ),
                        labelText: 'Contraseña'),
                    onChanged: (value) => {password = value},
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                          child: CustomCheckBox(
                        color: blue100,
                        key: checkBoxKey,
                        dimension: dimension,
                        offsetCheck: -8,
                        offsetText: -20,
                        text: [TextSpan(text: 'Remember me')],
                      )),
                      Expanded(
                          child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Olvidé mi contraseña',
                                textAlign: TextAlign.end,
                                style: TextStyle(color: blue100, fontSize: 13),
                              ))),
                    ],
                  ),
                  CustomButton(
                      text: 'Login',
                      width: dimension.width * 0.90,
                      height: dimension.height * 0.065,
                      onPressed: () => {
                            if (_formKey.currentState!.validate())
                              {
                                loginSlang(email, password).then((connection) =>
                                    {
                                      if (connection)
                                        {
                                          getPrefs().then((value) => {
                                                if (checkBoxKey
                                                    .currentState!.checked)
                                                  {
                                                    getPrefs().then((value) =>
                                                        value!.setStringList(
                                                            'login',
                                                            [email, password]))
                                                  },
                                                setState(
                                                    () => {loginOK = true}),
                                                Timer(
                                                    Duration(milliseconds: 700),
                                                    () {
                                                  changePageFade(
                                                      ChooseApp(), context);
                                                }),
                                              }),
                                        }
                                      else
                                        {
                                          Future.delayed(
                                              const Duration(
                                                  milliseconds: 5000), () {
                                            setState(() {
                                              isVisibleRegister = true;
                                            });
                                          }),
                                          customSnackBar(
                                              context,
                                              'Usuario o contraseña incorrectos.' +
                                                  '\nCompruebe los datos o regístrese.',
                                              4),
                                        }
                                    }),
                              }
                            else
                              {
                                setState(() => {
                                      customSnackBar(
                                          context,
                                          'Hay campos sin rellenar o con formato erróneo',
                                          2),
                                    }),
                              }
                          }),
                  TextButton(
                    onPressed: () => {changePageFade(UserRegister(), context)},
                    child: Text(
                      '¿Aún no tienes cuenta? Regístrate aquí',
                      style: TextStyle(
                        fontSize: 15,
                        color: blue100,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
