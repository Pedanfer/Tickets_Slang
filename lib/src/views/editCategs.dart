import 'dart:convert';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slang_mobile/src/functions/utilidades.dart';
import 'package:slang_mobile/src/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:slang_mobile/src/views/dashboard.dart';
import 'package:slang_mobile/main.dart';
import 'package:slang_mobile/src/views/menu.dart';
import '../utils/constants.dart';

GlobalKey<CustomCheckBoxState> checkBoxKey = GlobalKey();
var isSelected = <bool>[];

class editCategs extends StatefulWidget {
  @override
  State<editCategs> createState() => editCategsState();
}

class editCategsState extends State<editCategs> {
  Map<String, List<String>> categsSubCategsDict = {};
  List<String> categsNames = [];
  List<Widget> categsForms = [];

  final List<String> entries = <String>[
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
  ];
  final List<int> colorCodes = <int>[600, 500, 100];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ScrollController scrollController = ScrollController();
  bool isVisibleAddCategory = false;
  bool isVisibleAddSubcategory = false;

  @override
  Widget build(BuildContext context) {
    var dimension = MediaQuery.of(context).size;
    
          while (isSelected.length < entries.length){
                isSelected.add(false);
          }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset('lib/assets/icons/Burger_Menu.svg'),
          onPressed: () => changePageFade(Menu(), context),
        ),
        title: Container(
            padding: EdgeInsets.fromLTRB(60, 30, 60, 30),
            child: SvgPicture.asset('lib/assets/Slang/IconHorizontal.svg')),
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
        padding: EdgeInsets.only(
            left: dimension.width * 0.035,
            right: dimension.width * 0.035,
            top: dimension.height * 0.01),
        decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("lib/assets/backgrounds/fondo.png"),
                fit: BoxFit.cover,
              ),
            ),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                child: Column(
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
                    Divider(
                      color: Colors.white,
                      thickness: 0.5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Categorías:',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Container(
                          height: dimension.height * 0.05,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisibleAddCategory = !isVisibleAddCategory;
                              });
                            },
                            icon: isVisibleAddCategory
                                ? Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  )
                                : SvgPicture.asset(
                                    'lib/assets/icons/PlusIconRounded.svg'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: dimension.height * 0.55,
                child: Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: entries.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: Column(children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        setState(() {
                                          isSelected[index] =
                                              !isSelected[index];
                                        });
                                      },
                                      icon: isSelected[index] == true ? SvgPicture.asset('lib/assets/icons/MenosIcon.svg')
                                      : SvgPicture.asset('lib/assets/icons/PlusIcon.svg')
                                    ),
                                  ),
                                  Container(
                                    width: dimension.width * 0.5,
                                    child: Text(
                                      'Categoria: ${entries[index]}',
                                      style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontFamily: 'IBM Plex Sans',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                      child: Row(
                                    children: [
                                      Container(
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () => {},
                                          icon: Icon(Icons.edit,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Container(
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () => {},
                                          icon: Icon(Icons.delete,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  )),
                                ]),
                            Visibility(
                              visible: isSelected[index],
                              child: Column(children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: dimension.width * 0.1,
                                    ),
                                    Text(
                                      'Subcategorías:',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: dimension.height * 0.015,
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      dimension.width * 0.20, 0, 0, 0),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 20,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '· Subcategoria 1',
                                              style: TextStyle(
                                                color: Color(0xFFFFFFFF),
                                                fontFamily: 'IBM Plex Sans',
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Container(
                                              child: Row(children: [
                                                Container(
                                                  child: IconButton(
                                                      padding: EdgeInsets.zero,
                                                      onPressed: () {},
                                                      icon: Icon(
                                                        Icons.edit,
                                                        size: 20,
                                                        color: Colors.white,
                                                      )),
                                                ),
                                                Container(
                                                  child: IconButton(
                                                      padding: EdgeInsets.zero,
                                                      onPressed: () {},
                                                      icon: Icon(
                                                        Icons.delete,
                                                        size: 20,
                                                        color: Colors.white,
                                                      )),
                                                )
                                              ]),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: dimension.height * 0.01,
                                      ),
                                      Container(
                                        height: 20,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '· Subcategoria 2',
                                              style: TextStyle(
                                                color: Color(0xFFFFFFFF),
                                                fontFamily: 'IBM Plex Sans',
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Container(
                                              child: Row(children: [
                                                Container(
                                                  child: IconButton(
                                                      padding: EdgeInsets.zero,
                                                      onPressed: () {},
                                                      icon: Icon(
                                                        Icons.edit,
                                                        size: 20,
                                                        color: Colors.white,
                                                      )),
                                                ),
                                                Container(
                                                  child: IconButton(
                                                      padding: EdgeInsets.zero,
                                                      onPressed: () {},
                                                      icon: Icon(
                                                        Icons.delete,
                                                        size: 20,
                                                        color: Colors.white,
                                                      )),
                                                )
                                              ]),
                                            )
                                          ],
                                        ),
                                      )
                                    ], //categsForms,
                                  ),
                                ),
                                SizedBox(
                                  height: dimension.height * 0.015,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: dimension.width * 0.2,
                                    ),
                                    Visibility(
                                      visible: isVisibleAddSubcategory,
                                      child: Flexible(
                                        child: Container(
                                          height: dimension.height * 0.025,
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
                                    ),),
                                  ],
                                ),
                                      SizedBox(
                                        height: dimension.height * 0.01,
                                      ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: dimension.width * 0.2,
                                    ),
                                    InkWell(
                                      child: Text(
                                        '+ Añadir subcategoría',
                                        style: TextStyle(
                                            color: Color(0xFFA0A9C0), fontSize: 16),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          isVisibleAddSubcategory =
                                              !isVisibleAddSubcategory;
                                        });

                                        /*
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
                                      setState(() {});*/
                                      },
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: dimension.height * 0.02,
                                ),
                              ]),
                            ),
                          ]),
                        );
                      }),
                ),
              ),
              SizedBox(height: dimension.height * 0.02),
              Container(
                child: Column(children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.white,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      backgroundColor: Color(0xFF011A58),
                      elevation: 1.0,
                      minimumSize: Size(
                        double.infinity,
                        dimension.height * 0.06,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Salir sin guardar',
                        style: GoogleFonts.ibmPlexSans(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                  CustomButton(
                      text: 'Guardar y salir',
                      width: double.infinity,
                      height: dimension.height * 0.06,
                      onPressed: () {
                        formKey.currentState!.validate();
                        if (categsNames[0] != '') {
                          categsSubCategsDict.putIfAbsent(categsNames[0],
                              () => categsNames.sublist(1, categsNames.length));
                        }
                        prefs.setString(
                            'categs', json.encode(categsSubCategsDict));
                        Navigator.pop(context);
                      }),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
