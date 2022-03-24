import 'dart:async';

import 'package:exploration_planner/src/communications.dart';
import 'package:exploration_planner/src/dashboard.dart';
import 'package:exploration_planner/src/validators.dart' as validators;
import 'package:exploration_planner/src/widgets.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var robotWelcome = Image.asset('lib/assets/ticketRobot.png');
  var marginError = 0.03;
  bool loginOK = false;
  var email;
  var password;
  final robotOK = Image.asset('lib/assets/okRobot.png', scale: 2);
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    final dimension = MediaQuery.of(context).size;
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: loginOK
                ? [robotOK]
                : [
                    MediaQuery.of(context).viewInsets.bottom == 0
                        ? robotWelcome
                        : Image.asset('lib/assets/ticketRobot.png', scale: 2),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      height: dimension.height * 0.25,
                      margin: EdgeInsets.symmetric(
                          horizontal: dimension.width * 0.05,
                          vertical: dimension.width * 0.05),
                      padding: EdgeInsets.symmetric(
                          horizontal: dimension.width * 0.05,
                          vertical: dimension.height * marginError),
                      child: Column(
                        children: [
                          TextFormField(
                            validator: validators.validateEmail,
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                errorStyle: TextStyle(fontSize: 10, height: 1),
                                icon: Icon(Icons.mail_outline_rounded),
                                hintText: 'ejemplo@mail.com',
                                labelText: 'Email'),
                            onChanged: (value) => setState(() => {
                                  if (value.isEmpty)
                                    {
                                      marginError =
                                          _formKey.currentState!.validate()
                                              ? 0.03
                                              : 0.015
                                    },
                                  email = value
                                }),
                          ),
                          TextFormField(
                            validator: validators.validatePassword,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            autocorrect: false,
                            obscureText: !_showPassword ? true : false,
                            decoration: InputDecoration(
                                errorMaxLines: 3,
                                errorStyle: TextStyle(fontSize: 10, height: 1),
                                suffixIcon: InkWell(
                                    onTap: () => setState(() {
                                          _showPassword = !_showPassword;
                                        }),
                                    child: _showPassword
                                        ? Icon(Icons.visibility)
                                        : Icon(Icons.visibility_off)),
                                icon: Icon(Icons.lock),
                                labelText: 'Contraseña'),
                            onChanged: (value) => {password = value},
                          ),
                        ],
                      ),
                    ),
                    CustomButton(
                        text: 'ENTRAR',
                        width: dimension.width * 0.90,
                        onPressed: () => {
                              if (_formKey.currentState!.validate())
                                {
                                  loginSlang(email, password)
                                      .then((connection) => {
                                            if (connection)
                                              {
                                                setState(
                                                    () => {loginOK = true}),
                                                Timer(
                                                    Duration(milliseconds: 500),
                                                    () {
                                                  Navigator.push(
                                                    context,
                                                    PageRouteBuilder(
                                                      pageBuilder:
                                                          (c, a1, a2) =>
                                                              DashBoard(),
                                                      transitionsBuilder: (c,
                                                              anim,
                                                              a2,
                                                              child) =>
                                                          FadeTransition(
                                                              opacity: anim,
                                                              child: child),
                                                      transitionDuration:
                                                          Duration(
                                                              milliseconds:
                                                                  700),
                                                    ),
                                                  );
                                                }),
                                              }
                                            else
                                              {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Usuario o contraseña incorrectos.'),
                                                  duration:
                                                      Duration(seconds: 2),
                                                )),
                                              }
                                          }),
                                }
                              else
                                {
                                  setState(() => {
                                        marginError =
                                            _formKey.currentState!.validate()
                                                ? 0.03
                                                : 0.015,
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              'Hay campos sin rellenar o con formato erróneo'),
                                          duration: Duration(seconds: 2),
                                        )),
                                      }),
                                }
                            })
                  ],
          ),
        ),
      ),
    );
  }
}
