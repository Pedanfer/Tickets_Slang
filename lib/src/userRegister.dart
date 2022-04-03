import 'package:exploration_planner/src/communications.dart';
import 'package:exploration_planner/src/login_page.dart';
import 'package:exploration_planner/src/validators.dart' as validators;
import 'package:exploration_planner/src/widgets.dart';
import 'package:flutter/material.dart';

var dimension;
bool isVisibleRegister = false;

class UserRegister extends StatefulWidget {
  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  bool loginOK = false;
  var email;
  var password;
  var phone;
  var name;
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
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                height: dimension.height * 0.5,
                margin: EdgeInsets.symmetric(
                    horizontal: dimension.width * 0.05,
                    vertical: dimension.width * 0.05),
                padding: EdgeInsets.symmetric(
                    horizontal: dimension.width * 0.05,
                    vertical: dimension.height * 0.01),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextFormField(
                      validator: validators.validateName,
                      keyboardType: TextInputType.name,
                      autocorrect: false,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          errorStyle: TextStyle(fontSize: 10, height: 1),
                          icon: Icon(Icons.abc_rounded,
                              size: dimension.height * 0.04),
                          labelText: 'Nombre'),
                      onChanged: (value) => setState(() => {name = value}),
                    ),
                    TextFormField(
                      validator: validators.validatePhone,
                      keyboardType: TextInputType.phone,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      autocorrect: false,
                      decoration: InputDecoration(
                          errorMaxLines: 3,
                          errorStyle: TextStyle(fontSize: 10, height: 1),
                          icon: Icon(Icons.phone),
                          labelText: 'Teléfono'),
                      onChanged: (value) => {phone = value},
                    ),
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
                      onChanged: (value) => setState(() => {email = value}),
                    ),
                    TextFormField(
                      validator: validators.validateCreatedPassword,
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
                      onChanged: (value) => {password = value},
                    ),
                    SizedBox(height: dimension.height * 0.01)
                  ],
                ),
              ),
              CustomButton(
                text: 'REGISTRARME',
                width: dimension.width * 0.90,
                onPressed: () => {
                  if (_formKey.currentState!.validate())
                    {
                      registerSlang(name, phone, email, password).then(
                        (connection) => {
                          if (connection)
                            {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                backgroundColor: Color(0xff011A58),
                                content: Text(
                                    'Complete el registro en su correo, por favor.\nNo podrá utilizar Slang hasta entonces.',
                                    style: TextStyle(fontSize: 14),
                                    textAlign: TextAlign.center),
                                duration: Duration(seconds: 5),
                              )),
                              setState(() => {loginOK = true}),
                              Future.delayed(
                                Duration(milliseconds: 5500),
                                () => {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (c, a1, a2) => LoginPage(),
                                      transitionsBuilder:
                                          (c, anim, a2, child) =>
                                              FadeTransition(
                                                  opacity: anim, child: child),
                                      transitionDuration:
                                          Duration(milliseconds: 700),
                                    ),
                                  )
                                },
                              ),
                            }
                        },
                      )
                    }
                  else
                    {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Color(0xff011A58),
                          content: Text(
                              'Hay campos sin rellenar o con formato erróneo',
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.center),
                          duration: Duration(seconds: 2),
                        ),
                      ),
                    }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
