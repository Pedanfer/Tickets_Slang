import 'dart:convert';

import 'package:slang_mobile/src/tickets/functions/utilidades.dart';
import 'package:slang_mobile/src/tickets/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:slang_mobile/src/tickets/views/dashboard.dart';
import '../main.dart';
import '../utils/constants.dart';

GlobalKey<CustomCheckBoxState> checkBoxKey = GlobalKey();

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
                              text: 'categorías y subcategorías',
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
                                    'Categoría:',
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
                                  categsNames.add(value!);
                                  return;
                                },
                                initialValue: '',
                                keyboardType: TextInputType.name,
                                autocorrect: false,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  isDense: true,
                                  hintText: 'Construcciones Martínez S.L.',
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
                                    'Subcategoría:',
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
                                        categsNames.add(value!);
                                        return;
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
                                      '+ Añadir subcategoría',
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
                                                    categsNames.add(value!);
                                                    return;
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
                                      '+ Guardar y añadir categoría',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  formKey.currentState!.validate();
                                  categsSubCategsDict.putIfAbsent(
                                      categsNames[0],
                                      () => categsNames.sublist(
                                          1, categsNames.length));
                                  setState(() {
                                    categsForms = [];
                                    categsNames = [];
                                    formKey.currentState!.reset();
                                  });
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
                                  text: 'Guardar todo y continuar',
                                  width: double.infinity,
                                  height: dimension.height * 0.06,
                                  onPressed: () {
                                    formKey.currentState!.validate();
                                    if (categsNames[0] != '') {
                                      categsSubCategsDict.putIfAbsent(
                                          categsNames[0],
                                          () => categsNames.sublist(
                                              1, categsNames.length));
                                    }
                                    prefs.setString('categs',
                                        json.encode(categsSubCategsDict));
                                    changePageFade(DashBoard(), context);
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
}
