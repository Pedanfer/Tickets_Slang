import 'dart:io';
import 'package:exploration_planner/src/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsx;

final imgPicker = ImagePicker();
List<int>? imgBytes;
File? imageFile;
SharedPreferences? prefs;

Future<Image> photoFrom(String source) async {
  var _pickedFile = await imgPicker.pickImage(
      source: source == 'camera' ? ImageSource.camera : ImageSource.gallery);
  if (_pickedFile?.path != null) {
    imageFile = File(_pickedFile!.path);
    imgBytes = imageFile!.readAsBytesSync();
    return Image.file(imageFile!, height: 450, width: 380);
  } else {
    return Image.asset('lib/assets/ticketRobot.png', height: 450, width: 380);
  }
}

Future<File> createExcelFicha(Map<String, dynamic> ticketData) async {
// Create a new Excel document.
  final workbook = xlsx.Workbook();

// Accessing worksheet via index.
  final sheet = workbook.worksheets[0];

// Set value to cell.
  // CABECERA
  sheet.getRangeByName('A1').setText('FECHA');
  sheet.getRangeByName('B1').setText('HORA');
  sheet.getRangeByName('C1').setText('CATEGORIA 1');
  sheet.getRangeByName('D1').setText('CATEGORIA 2');

  // CONTENIDO
  sheet.getRangeByName('A2').setText(ticketData['date']);
  sheet.getRangeByName('B2').setText(ticketData['hour']);
  sheet.getRangeByName('C2').setText(ticketData['categ']);
  //sheet.getRangeByName('D2').setText(categ2);

//Defining a global style with properties.
  final globalStyle = workbook.styles.add('globalStyle');
  globalStyle.backColor = '#37D8E9';
  globalStyle.fontName = 'Times New Roman';
  globalStyle.fontSize = 12;
  globalStyle.fontColor = '#C67878';
  globalStyle.italic = true;
  globalStyle.bold = true;
  globalStyle.underline = true;
  globalStyle.wrapText = true;
  globalStyle.hAlign = xlsx.HAlignType.center;
  globalStyle.vAlign = xlsx.VAlignType.center;
  globalStyle.borders.all.lineStyle = xlsx.LineStyle.thick;
  globalStyle.borders.all.color = '#9954CC';

  final globalStyle1 = workbook.styles.add('globalStyle1');
  globalStyle1.fontSize = 14;
  globalStyle1.fontColor = '#362191';
  globalStyle1.hAlign = xlsx.HAlignType.center;
  globalStyle1.vAlign = xlsx.VAlignType.center;
  globalStyle1.borders.bottom.lineStyle = xlsx.LineStyle.thin;
  globalStyle1.borders.bottom.color = '#829193';
  globalStyle1.numberFormat = '0.00';

//Apply GlobalStyle
  sheet.getRangeByName('A1:D1').cellStyle = globalStyle;

//Apply GlobalStyle1
  sheet.getRangeByName('A2:D2').cellStyle = globalStyle1;

// Auto-Fit
  for (var i = 1; i <= 4; i++) {
    sheet.autoFitColumn(i);
    sheet.autoFitRow(i);
  }

/* Insert image
  var foto = File(rutaImagen);
  final List<int> imageBytes = foto.readAsBytesSync();
  sheet.pictures.addStream(3, 1, imageBytes);*/

// Save and dispose the document.
  final bytes = workbook.saveAsStream();
  workbook.dispose();

// Save on Internal Storage
  final path = (await getApplicationSupportDirectory()).path;
  final fileName = '$path/Output.xlsx';
  final file = File(fileName);
  await file.writeAsBytes(bytes, flush: true);
  print(file);
  saveExcel(file);
  return file;
}

Future<File> createExcelLista(List<File> rutaImagen) async {
// Create a new Excel document.
  final workbook = xlsx.Workbook();

// Accessing worksheet via index.
  final sheet = workbook.worksheets[0];

// Set value to cell.
  // CABECERA
  sheet.getRangeByName('A1').setText('FECHA');
  sheet.getRangeByName('B1').setText('HORA');
  sheet.getRangeByName('C1').setText('CATEGORIA 1');
  sheet.getRangeByName('D1').setText('CATEGORIA 2');

  for (var i = 0; i < rutaImagen.length; i++) {
    var filtrado1 = rutaImagen[i].path.split('.');
    var filtradocategs = filtrado1[3].split('|');
    var filtrado2 = filtrado1[2].split('/');
    var filtradotiempo = filtrado2[2].split('-');
    var categ1;
    var categ2;
    var fecha =
        filtradotiempo[2] + '/' + filtradotiempo[1] + '/' + filtradotiempo[0];
    var hora = filtradotiempo[3] + ':' + filtradotiempo[4];

    if (filtrado1[3].contains('|')) {
      categ1 = filtradocategs[0];
      categ2 = filtradocategs[1];
    } else {
      categ1 = '';
      categ2 = '';
    }

    if (categ1 == '') {
      categ1 = 'Vacio';
    }

    if (categ2 == '') {
      categ2 = 'Vacio';
    }

    print('entra');

// Set value to cell.

    // CONTENIDO
    sheet.getRangeByName('A' + (i + 2).toString()).setText(fecha);
    sheet.getRangeByName('B' + (i + 2).toString()).setText(hora);
    sheet.getRangeByName('C' + (i + 2).toString()).setText(categ1);
    sheet.getRangeByName('D' + (i + 2).toString()).setText(categ2);
  }

//Defining a global style with properties.
  final globalStyle = workbook.styles.add('globalStyle');
  globalStyle.backColor = '#37D8E9';
  globalStyle.fontName = 'Times New Roman';
  globalStyle.fontSize = 12;
  globalStyle.fontColor = '#C67878';
  globalStyle.italic = true;
  globalStyle.bold = true;
  globalStyle.underline = true;
  globalStyle.wrapText = true;
  globalStyle.hAlign = xlsx.HAlignType.center;
  globalStyle.vAlign = xlsx.VAlignType.center;
  globalStyle.borders.all.lineStyle = xlsx.LineStyle.thick;
  globalStyle.borders.all.color = '#9954CC';

  final globalStyle1 = workbook.styles.add('globalStyle1');
  globalStyle1.fontSize = 14;
  globalStyle1.fontColor = '#362191';
  globalStyle1.hAlign = xlsx.HAlignType.center;
  globalStyle1.vAlign = xlsx.VAlignType.center;
  globalStyle1.borders.bottom.lineStyle = xlsx.LineStyle.thin;
  globalStyle1.borders.bottom.color = '#829193';
  globalStyle1.numberFormat = '0.00';

//Apply GlobalStyle
  sheet.getRangeByName('A1:D1').cellStyle = globalStyle;

//Apply GlobalStyle1
  sheet.getRangeByName('A2:D' + (rutaImagen.length + 1).toString()).cellStyle =
      globalStyle1;

// Auto-Fit
  for (var i = 1; i <= 4; i++) {
    sheet.autoFitColumn(i);
    sheet.autoFitRow(i);
  }

// Save and dispose the document.
  final bytes = workbook.saveAsStream();
  workbook.dispose();

// Save on Internal Storage
  final path = (await getApplicationSupportDirectory()).path;
  final fileName = '$path/Output.xlsx';
  final file = File(fileName);
  await file.writeAsBytes(bytes, flush: true);
  print(file);
  saveExcel(file);
  return file;
}

Future<bool> InsertListElement(BuildContext context, int lista) async {
  var text = Text('');
  var nuevaCategoria = '';
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            insetPadding: EdgeInsets.all(dimension.width * 0.07),
            title: Text(
              '¿Como se llamará la nueva categoría?',
              style: TextStyle(fontSize: 16),
            ),
            content:
                TextFormField(onChanged: (value) => nuevaCategoria = value),
            actions: <Widget>[
              Center(child: text),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    child: Text('Cancelar'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    child: Text('Aceptar'),
                    onPressed: () {
                      nuevaCategoria = nuevaCategoria.trim();

                      if (nuevaCategoria.length <= 10) {
                        if (nuevaCategoria != '') {
                          if (nuevaCategoria.contains('.') == false) {
                            nuevaCategoria =
                                nuevaCategoria.replaceAll('.', '+');
                            saveCategToPrefs(categ: nuevaCategoria, num: lista);

                            Navigator.pop(context);
                          } else {
                            text = Text('No puede contener puntos');
                          }
                        } else {
                          text = Text(
                              'No puede estar vacío o contener solo espacios');
                        }
                      } else {
                        text = Text(
                            'La longitud tiene que ser de 1 a 10 caracteres');
                      }
                      setState(() => {});
                    },
                  ),
                ],
              )
            ],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          );
        });
      });
  return true;
}

Future<bool> dialogRemoveReceipt(BuildContext context, String date) async {
  var accept = false;
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¿Seguro que quiere eliminar esta factura?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
                child: Text('Aceptar'),
                onPressed: () {
                  removeReceipt(date);
                  Navigator.pop(context);
                  accept = true;
                }),
          ],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        );
      });
  return accept;
}

Future<SharedPreferences?> getPrefs() async {
  prefs = await SharedPreferences.getInstance();
  var catsLoaded = prefs!.getBool('categsLoaded') ?? false;
  if (!catsLoaded) {
    await prefs!.setStringList('categList1', []);
    //await prefs!.setStringList('categList2', []);
    await prefs!.setBool('categsLoaded', true);
  }
  return prefs;
}

void saveCategToPrefs({required String categ, required int num}) {
  var nomLista = num == 1 ? 'categList1' : 'categList2';
  var listaCategs = prefs!.getStringList(nomLista);
  listaCategs!.add(categ);
  prefs!.setStringList(nomLista, listaCategs);
}

/*void saveFile(File? image, String categs) async {
  if (Platform.isAndroid && await _requestPermission(Permission.storage)) {
    var date = DateTime.now()
            .toString()
            .substring(0, 19)
            .replaceAll(RegExp(r' |:'), '-') +
        categs +
        '.jpg';
    var directory = await getExternalStorageDirectory();
    imgBytes = await image!.copy(directory!.path + '/$date');
    await image.delete();
  }
}*/

void saveExcel(File? image) async {
  if (Platform.isAndroid && await _requestPermission(Permission.storage)) {
    var date = DateTime.now()
            .toString()
            .substring(0, 19)
            .replaceAll(RegExp(r' |:'), '-') +
        '.xlsx';
    var directory = await getExternalStorageDirectory();
    //Tono: adaptar código de guardado de excel sin variable global
    await image!.copy(directory!.path + '/$date');
    await image.delete();
  }
}

List<File> getFiles() {
  if (Platform.isAndroid) {
    var dir;
    var files = <File>[];
    getExternalStorageDirectory().then((value) {
      dir = value;
      for (var item in dir.listSync()) {
        if (item.toString().contains('.jpg')) {
          files.add(item as File);
        }
      }
    });
    return files;
  }
  return <File>[];
}

void removeReceipt(String date) {
  getExternalStorageDirectory().then((value) {
    var dir = value;
    for (var item in dir!.listSync()) {
      item = item as File;
      if (item.path.split('/').last.contains(date)) {
        item.delete();
      }
    }
  });
}

Future<bool> _requestPermission(Permission permission) async {
  if (await permission.isGranted) {
    return true;
  } else {
    var result = await permission.request();
    if (result == PermissionStatus.granted) {
      return true;
    }
  }
  return false;
}
