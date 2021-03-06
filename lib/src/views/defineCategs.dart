import 'dart:convert';

import 'package:slang_mobile/src/functions/utilidades.dart';
import 'package:slang_mobile/src/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:slang_mobile/src/views/dashboard.dart';
import 'package:slang_mobile/main.dart';
import '../utils/constants.dart';

var categNum = 1;

class DefineCategs extends StatefulWidget {
  @override
  State<DefineCategs> createState() => DefineCategsState();
}

class DefineCategsState extends State<DefineCategs> {
  Map<String, List<String>> categsSubCategsDict = {};
  List<String> categsNames = [];
  List<Widget> categsForms = [];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20.0),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Define las ',
                                style: TextStyle(fontWeight: FontWeight.w200)),
                            TextSpan(
                              text: 'categor??as y subcategor??as',
                            ),
                            TextSpan(
                                text: ' para mantener los tickets ordenados',
                                style: TextStyle(fontWeight: FontWeight.w200)),
                          ],
                        ),
                      ),
                      Form(
                          key: formKey,
                          child: Column(
                            children: [
                              TitleWithUnderline(
                                  color: Colors.white,
                                  text: '',
                                  fontSize: 16,
                                  spaceLength:
                                      (49 * (dimension.width * 0.005)).round(),
                                  dashed: true),
                              SizedBox(
                                height: dimension.height * 0.015,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Categor??a $categNum:',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: dimension.height * 0.015,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Campo vac??o';
                                  } else {
                                    categsNames.add(value);
                                  }
                                  return null;
                                },
                                initialValue: '',
                                keyboardType: TextInputType.name,
                                autocorrect: false,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  isDense: true,
                                  hintText: 'Construcciones Mart??nez S.L.',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide.none),
                                  contentPadding:
                                      EdgeInsets.all(dimension.width * 0.024),
                                  filled: true,
                                  fillColor: formBackground,
                                ),
                              ),
                              SizedBox(
                                height: dimension.height * 0.015,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: dimension.width * 0.12,
                                  ),
                                  Text(
                                    'Subcategor??a:',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: dimension.height * 0.015,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: dimension.width * 0.12,
                                  ),
                                  Flexible(
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Campo vac??o';
                                        } else {
                                          categsNames.add(value);
                                        }
                                        return null;
                                      },
                                      initialValue: '',
                                      keyboardType: TextInputType.name,
                                      autocorrect: false,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: 'Tarjeta La Caixa',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide.none),
                                        contentPadding: EdgeInsets.all(
                                            dimension.width * 0.024),
                                        filled: true,
                                        fillColor: formBackground,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: dimension.height * 0.015,
                              ),
                              Column(
                                children: categsForms,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: dimension.width * 0.12,
                                  ),
                                  InkWell(
                                    child: Text(
                                      '+ A??adir subcategor??a',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                    onTap: () {
                                      categsForms.add(Column(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: dimension.width * 0.12,
                                              ),
                                              Flexible(
                                                child: TextFormField(
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Campo vac??o';
                                                    } else {
                                                      categsNames.add(value);
                                                    }
                                                    return null;
                                                  },
                                                  initialValue: '',
                                                  keyboardType:
                                                      TextInputType.name,
                                                  autocorrect: false,
                                                  onChanged: (value) => {},
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    hintText:
                                                        'Tarjeta La Caixa',
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        borderSide:
                                                            BorderSide.none),
                                                    contentPadding:
                                                        EdgeInsets.all(
                                                            dimension.width *
                                                                0.024),
                                                    filled: true,
                                                    fillColor: formBackground,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: dimension.height * 0.015,
                                          ),
                                        ],
                                      ));
                                      setState(() {});
                                    },
                                  )
                                ],
                              ),
                              SizedBox(
                                height: dimension.height * 0.02,
                              ),
                              TitleWithUnderline(
                                  color: Colors.white,
                                  text: '',
                                  fontSize: 16,
                                  spaceLength:
                                      (49 * (dimension.width * 0.005)).round(),
                                  dashed: true),
                              SizedBox(
                                height: dimension.height * 0.02,
                              ),
                              InkWell(
                                child: Row(
                                  children: [
                                    Text(
                                      '+ Guardar categor??a',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    auxSaveCategs();
                                    setState(() {
                                      categNum++;
                                      categsForms = [];
                                      categsNames = [];
                                      formKey.currentState!.reset();
                                    });
                                  } else {
                                    categsNames = [];
                                    customSnackBar(context,
                                        'Has olvidado rellenar alg??n campo', 3);
                                  }
                                },
                              ),
                              TitleWithUnderline(
                                  color: Colors.white,
                                  text: '',
                                  fontSize: 16,
                                  spaceLength:
                                      (49 * (dimension.width * 0.005)).round(),
                                  dashed: true),
                              SizedBox(height: dimension.height * 0.02),
                              CustomButton(
                                  text: 'Continuar',
                                  width: double.infinity,
                                  height: dimension.height * 0.06,
                                  onPressed: () {
                                    formKey.currentState!.validate();
                                    if (categsNames.isEmpty) {
                                      if (!categsSubCategsDict.values.isEmpty) {
                                        prefs.setString('categs',
                                            json.encode(categsSubCategsDict));
                                        changePageFadeRemoveUntil(
                                            DashBoard(), context);
                                      } else {
                                        customSnackBar(
                                            context,
                                            'Has de especificar al menos una categor??a',
                                            3);
                                      }
                                    } else {
                                      categsNames = [];
                                      customSnackBar(
                                          context,
                                          'Guarde la ??ltima categor??a antes de continuar',
                                          3);
                                    }
                                  }),
                              SizedBox(height: dimension.height * 0.02),
                            ],
                          )),
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

  auxSaveCategs() {
    if (categsNames[0] != '') {
      var categList = categsNames.sublist(1, categsNames.length);
      categsSubCategsDict.putIfAbsent(categsNames[0], () => categList);
    }
  }
}
