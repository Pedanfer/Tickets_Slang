import 'dart:convert';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:slang_mobile/src/functions/utilidades.dart';
import 'package:slang_mobile/src/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:slang_mobile/src/views/dashboard.dart';
import 'package:slang_mobile/main.dart';
import 'package:slang_mobile/src/views/menu.dart';
import '../utils/constants.dart';

GlobalKey<CustomCheckBoxState> checkBoxKey = GlobalKey();

class editCategs extends StatefulWidget {
  @override
  State<editCategs> createState() => editCategsState();
}

class editCategsState extends State<editCategs> {
  Map<String, List<String>> categsSubCategsDict = {};
  List<String> categsNames = [];
  List<Widget> categsForms = [];

  final List<String> entries = <String>['A', 'B', 'C'];
final List<int> colorCodes = <int>[600, 500, 100];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ScrollController scrollController = ScrollController();
  bool isVisibleAddCategory = false;

  @override
  Widget build(BuildContext context) {
    var dimension = MediaQuery.of(context).size;
    
    return Scaffold(
appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset('lib/assets/icons/Burger_Menu.svg'),
          onPressed: () => changePageFade(Menu(), context),
        ),
        title: Container(
            padding: EdgeInsets.fromLTRB(60, 30, 60, 30),
            child: SvgPicture.asset(
                'lib/assets/Slang/IconHorizontal.svg')),
        actions: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.person)),
        ],
        backgroundColor: Color(0xFF011A58),
      ),

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
                                text: 'Edita las ',
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
                      Column(
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Categorías:',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  IconButton(onPressed: () {setState(() {isVisibleAddCategory = !isVisibleAddCategory;});}, icon: isVisibleAddCategory ? Icon(Icons.check, color: Colors.white,) :SvgPicture.asset('lib/assets/icons/PlusIcon.svg'))
                                ],
                              ),
                              TitleWithUnderline(
                                  color: Colors.white,
                                  text: '',
                                  fontSize: 16,
                                  spaceLength:
                                      (49 * (dimension.width * 0.005)).round(),
                                  dashed: true),






















Container(child: 
ListView.builder(
  itemCount: entries.length,
  itemBuilder: (BuildContext context, int index) {
    return Container(
      height: 50,
      color: Colors.amber[colorCodes[index]],
      child: Center(child: Text('Entry ${entries[index]}')),
    );
  }
),),

























                              Visibility(
                                visible: isVisibleAddCategory,
                                child: Container(child: Column(children: [
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
                              ]),),),TitleWithUnderline(
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
                                  text: 'Guardar y salir',
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
                                   Navigator.pop(context);
                                  }),
                              SizedBox(height: dimension.height * 0.02),
                            ],
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
