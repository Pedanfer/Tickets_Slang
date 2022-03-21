import 'package:exploration_planner/src/validators.dart' as validators;
import 'package:exploration_planner/src/widgets.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var robotWelcome = Image.asset('lib/assets/ticketRobot.png', scale: 11);
  var marginError = 0.03;
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
              Color.fromARGB(255, 178, 204, 226),
              Color.fromARGB(255, 112, 221, 145),
            ],
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              robotWelcome,
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                height: dimension.height * 0.25,
                margin: EdgeInsets.only(
                    left: dimension.width * 0.05,
                    right: dimension.width * 0.05),
                padding: EdgeInsets.symmetric(
                    horizontal: dimension.width * 0.05,
                    vertical: dimension.height * marginError),
                child: Column(
                  children: [
                    TextFormField(
                      validator: validators.validateEmail,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          errorStyle: TextStyle(fontSize: 10, height: 1),
                          icon: Icon(Icons.mail_outline_rounded),
                          hintText: 'ejemplo@mail.com',
                          labelText: 'Email'),
                      onChanged: (value) => setState(() => {
                            if (value.isEmpty)
                              marginError = _formKey.currentState!.validate()
                                  ? 0.03
                                  : 0.015
                          }),
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            setState(() => {robotWelcome = robotOK})
                          }
                        else
                          {
                            setState(() => {
                                  marginError =
                                      _formKey.currentState!.validate()
                                          ? 0.03
                                          : 0.015,
                                  showDialog(
                                      context: context,
                                      builder: (_) => CustomAlertDialog()),
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
