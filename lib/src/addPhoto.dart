import 'package:flutter/material.dart';
import 'communications.dart';
import 'utilidades.dart';

class AddPhoto extends StatefulWidget {
  @override
  State<AddPhoto> createState() => AddPhotoState();
}

class AddPhotoState extends State<AddPhoto> {
  var categs = '';
  bool isVisibleBorrarAceptar = false;
  bool isVisibleFotoGaleria = true;
  bool isVisibleCategorias = false;
  String vista = 'Seleccione categoría';
  String vista2 = 'Seleccione categoría';
  var img = Image.asset(
    'lib/assets/ticketRobot.png',
  );

  @override
  Widget build(BuildContext context) {
    final dimension = MediaQuery.of(context).size;
    return FutureBuilder(
        future: getPrefs(),
        builder: (context, snapshot) {
          return Container(
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
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              width: double.infinity - 20,
              height: double.infinity - 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  img,
                  Visibility(
                    visible: isVisibleCategorias,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(children: [
                        Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 2.5),
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(color: Colors.black),
                                      color: Colors.white),
                                  child: DropdownButton(
                                    icon: Icon(Icons.arrow_drop_down,
                                        color: Colors.black),
                                    items: prefs!
                                        .getStringList('categList1')!
                                        .map((String e) {
                                      return DropdownMenuItem(
                                          value: e, child: Text(e));
                                    }).toList(),
                                    onChanged: (value) => {
                                      categs += '.' + value.toString() + '|',
                                      setState(() {
                                        vista = value.toString();
                                      })
                                    },
                                    hint: Text(
                                      vista,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: IconButton(
                                    icon: Icon(Icons.add_box),
                                    iconSize: 40,
                                    onPressed: () {
                                      InsertListElement(context, 1)
                                          .then((value) => setState(() {}));
                                    },
                                  ),
                                )
                              ]),
                        ),
                        Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 2.5),
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(color: Colors.black),
                                      color: Colors.white),
                                  child: DropdownButton(
                                      items: prefs!
                                          .getStringList('categList2')!
                                          .map((String e) {
                                        return DropdownMenuItem(
                                            value: e, child: Text(e));
                                      }).toList(),
                                      onChanged: (value) => {
                                            categs += value.toString(),
                                            setState(() {
                                              vista2 = value.toString();
                                            })
                                          },
                                      hint: Text(vista2)),
                                ),
                                Container(
                                  child: IconButton(
                                    icon: Icon(Icons.add_box),
                                    iconSize: 40,
                                    onPressed: () {
                                      InsertListElement(context, 2)
                                          .then((value) => setState(() {}));
                                    },
                                  ),
                                )
                              ]),
                        )
                      ]),
                    ),
                  ),
                  Visibility(
                    visible: isVisibleFotoGaleria,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      height: dimension.height * 0.09,
                      width: dimension.width * 0.38,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xffD0098D)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.add_a_photo_sharp,
                              color: Colors.white,
                            ),
                            iconSize: 42,
                            onPressed: () {
                              photoFromCamera().then((value) => setState(() {
                                    saveFile(imageFile, categs);
                                    img = value;
                                    isVisibleBorrarAceptar = true;
                                    isVisibleFotoGaleria = false;
                                    isVisibleCategorias = true;
                                  }));
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.image,
                              color: Colors.white,
                            ),
                            iconSize: 42,
                            onPressed: () {
                              photoFromGallery().then((value) => setState(() {
                                    saveFile(imageFile, categs);
                                    img = value;
                                    isVisibleBorrarAceptar = true;
                                    isVisibleFotoGaleria = false;
                                    isVisibleCategorias = true;
                                  }));
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                      visible: isVisibleBorrarAceptar,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff415382),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              child: Text('BORRAR'),
                              onPressed: () {
                                setState(() {
                                  img =
                                      Image.asset('lib/assets/ticketRobot.png');
                                  isVisibleBorrarAceptar = false;
                                  isVisibleFotoGaleria = true;
                                  isVisibleCategorias = false;
                                });
                              },
                            ),
                            TextButton(
                              child: Text('ENVIAR'),
                              onPressed: () {
                                setState(() {
                                  uploadImageToSlang(categs, imageFile!);
                                  img =
                                      Image.asset('lib/assets/ticketRobot.png');
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Text(
                                              'El ticket se ha añadido correctamente'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text('OK'),
                                              onPressed: () {
                                                Navigator.pop(context, true);
                                              },
                                            ),
                                          ],
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                        );
                                      });
                                  isVisibleBorrarAceptar = false;
                                  isVisibleFotoGaleria = true;
                                  isVisibleCategorias = false;
                                });
                              },
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          );
        });
  }
}
