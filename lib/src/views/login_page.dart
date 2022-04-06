import 'dart:async';

import 'package:exploration_planner/src/functions/communications.dart';
import 'package:exploration_planner/src/views/dashboard.dart';
import 'package:exploration_planner/src/views/userRegister.dart';
import 'package:exploration_planner/src/utils/validators.dart' as validators;
import 'package:exploration_planner/src/utils/widgets.dart';
import 'package:flutter/material.dart';

var dimension;
bool isVisibleRegister = false;

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var robotWelcome = Image.asset('lib/assets/ticketRobot.png', scale: 1.2);
  bool loginOK = false;
  var email;
  var password;
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    dimension = MediaQuery.of(context).size;
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
                    MediaQuery.of(context).viewInsets.bottom == 0
                        ? robotWelcome
                        : Image.asset('lib/assets/ticketRobot.png', scale: 2.5),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      height: dimension.height * 0.3,
                      margin: EdgeInsets.symmetric(
                          horizontal: dimension.width * 0.05,
                          vertical: dimension.width * 0.05),
                      padding: EdgeInsets.symmetric(
                          horizontal: dimension.width * 0.05,
                          vertical: dimension.height * 0.03),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            onChanged: (value) =>
                                setState(() => {email = value}),
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
                          SizedBox(
                            height: dimension.height * 0.01,
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Visibility(
                          visible: isVisibleRegister,
                          child: CustomButton(
                            text: 'CREAR CUENTA NUEVA',
                            width: dimension.width * 0.90,
                            onPressed: () => {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (c, a1, a2) => UserRegister(),
                                  transitionsBuilder: (c, anim, a2, child) =>
                                      FadeTransition(
                                          opacity: anim, child: child),
                                  transitionDuration:
                                      Duration(milliseconds: 700),
                                ),
                              )
                            },
                          ),
                        ),
                        SizedBox(height: dimension.height * 0.01),
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
                                                        Duration(
                                                            milliseconds: 700),
                                                        () {
                                                      Navigator.pushAndRemoveUntil(
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
                                                        ),(Route<dynamic> route) => false);
                                                    }),
                                                  }
                                                else
                                                  {
                                                    Future.delayed(
                                                        const Duration(
                                                            milliseconds: 5000),
                                                        () {
                                                      setState(() {
                                                        isVisibleRegister =
                                                            true;
                                                      });
                                                    }),
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      backgroundColor:
                                                          Color(0xff011A58),
                                                      content: Text(
                                                          'Usuario o contraseña incorrectos.\nCompruebe los datos o regístrese.',
                                                          style: TextStyle(
                                                              fontSize: 14),
                                                          textAlign:
                                                              TextAlign.center),
                                                      duration:
                                                          Duration(seconds: 4),
                                                    )),
                                                  }
                                              }),
                                    }
                                  else
                                    {
                                      setState(() => {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              backgroundColor:
                                                  Color(0xff011A58),
                                              content: Text(
                                                  'Hay campos sin rellenar o con formato erróneo',
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                  textAlign: TextAlign.center),
                                              duration: Duration(seconds: 2),
                                            )),
                                          }),
                                    }
                                }),
                      ],
                    ),
                  ],
          ),
        ),
      ),
    );
  }
}
