import 'dart:io';
import 'dart:async';
import 'package:archive/archive_io.dart';
import 'package:slang_mobile/main.dart';
import 'package:slang_mobile/src/functions/sqlite.dart' as sqlite;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsx;
import '../utils/ticket.dart';

final imgPicker = ImagePicker();
List<int>? imgBytes;
File? imageFile;

Future<bool> photoFrom(String source) async {
  if (await requestPermission(Permission.camera) &&
      await requestPermission(Permission.storage)) {
    var _pickedFile = await imgPicker.pickImage(
        imageQuality: 50,
        source: source == 'camera' ? ImageSource.camera : ImageSource.gallery);
    if (_pickedFile?.path != null) {
      imageFile = File(_pickedFile!.path);
      imgBytes = imageFile!.readAsBytesSync();
      return true;
    }
  }
  return false;
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
  sheet.getRangeByName('C1').setText('CATEGORIA');
  sheet.getRangeByName('D1').setText('SUB-CATEGORIA');

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
  globalStyle1.fontColor = '#000000';
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

// Save and dispose the document.
  final bytes = workbook.saveAsStream();
  workbook.dispose();

// Save on Internal Storage
  final path = (await getApplicationSupportDirectory()).path;
  final fileName = '$path/Output.xlsx';
  final file = File(fileName);
  await file.writeAsBytes(bytes, flush: true);
  saveExcel(file);
  return file;
}

Future<void> createZipWithExcel(List<Ticket> listaTickets,
    {required bool storedDrive}) async {
  if (storedDrive) {
    sqlite.DB.updateSynchronized(listaTickets);
  }
  if (await requestPermission(Permission.storage)) {
    var dirToCompress;
    await getExternalStorageDirectory()
        .then((value) => dirToCompress = value!.path);
    var encoder = ZipFileEncoder();
    encoder.create(dirToCompress + '/Tickets.zip');

// Create a new Excel document.
    final workbook = xlsx.Workbook();

// Accessing worksheet via index.
    final sheet = workbook.worksheets[0];

// Set value to cell.
    // CABECERA
    sheet.getRangeByName('A1').setText('CONCEPTO');
    sheet.getRangeByName('B1').setText('EMISOR');
    sheet.getRangeByName('C1').setText('TOTAL');
    sheet.getRangeByName('D1').setText('FECHA');
    sheet.getRangeByName('E1').setText('HORA');
    sheet.getRangeByName('F1').setText('CATEGORIA');
    sheet.getRangeByName('G1').setText('SUB-CATEGORIA');

    for (var i = 0; i < listaTickets.length; i++) {
      // Set value to cell.
      var ticketData = listaTickets[i].toMap();

      // CONTENIDO
      sheet
          .getRangeByName('A' + (i + 2).toString())
          .setText(ticketData['ticketName']);
      sheet
          .getRangeByName('B' + (i + 2).toString())
          .setText(ticketData['issuer']);
      sheet
          .getRangeByName('C' + (i + 2).toString())
          .setText(ticketData['total'].toString() + '???');
      sheet
          .getRangeByName('D' + (i + 2).toString())
          .setText(ticketData['date']);
      sheet
          .getRangeByName('E' + (i + 2).toString())
          .setText(ticketData['hour']);
      sheet
          .getRangeByName('F' + (i + 2).toString())
          .setText(ticketData['categ1']);
      sheet
          .getRangeByName('G' + (i + 2).toString())
          .setText(ticketData['categ2']);

      await encoder.addFile(
          await File(dirToCompress + '/Ticket' + (i + 2).toString() + '.jpg')
              .writeAsBytes(ticketData['photo']));
    }

//Defining a global style with properties.
    final globalStyle = workbook.styles.add('globalStyle');
    globalStyle.backColor = '#37D8E9';
    globalStyle.fontName = 'Carlito';
    globalStyle.fontSize = 16;
    globalStyle.fontColor = '#000000';
    globalStyle.bold = true;
    globalStyle.wrapText = true;
    globalStyle.hAlign = xlsx.HAlignType.center;
    globalStyle.vAlign = xlsx.VAlignType.center;
    globalStyle.borders.all.lineStyle = xlsx.LineStyle.thick;
    globalStyle.borders.all.color = '#9954CC';

    final globalStyle1 = workbook.styles.add('globalStyle1');
    globalStyle1.fontSize = 14;
    globalStyle1.fontColor = '#000000';
    globalStyle1.hAlign = xlsx.HAlignType.center;
    globalStyle1.vAlign = xlsx.VAlignType.center;
    globalStyle1.borders.bottom.lineStyle = xlsx.LineStyle.thin;
    globalStyle1.borders.bottom.color = '#829193';
    globalStyle1.numberFormat = '0.00';

//Apply GlobalStyle
    sheet.getRangeByName('A1:G1').cellStyle = globalStyle;

//Apply GlobalStyle1
    sheet
        .getRangeByName('A2:G' + (listaTickets.length + 1).toString())
        .cellStyle = globalStyle1;

// Auto-Fit
    for (var i = 1; i <= 6; i++) {
      sheet.autoFitColumn(i);
      sheet.autoFitRow(i);
    }

// Save and dispose the document.
    final bytes = workbook.saveAsStream();
    workbook.dispose();
    await encoder.addFile(await File(dirToCompress + '/Tickets.xlsx')
        .writeAsBytes(bytes, flush: true));
    encoder.close();
  }
}

Future<bool> emptyAppDir() async {
  if (Platform.isAndroid) {
    var dir = await getExternalStorageDirectory();
    for (var file in await dir!.list().toList()) {
      await file.delete();
    }
  }
  return true;
}

//Hay que volver a utilizarlo
Future<bool> dialogRemoveTicket(
    BuildContext context, int id, List<Ticket>? ticketList) async {
  var accept = false;
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '??Seguro que quiere eliminar sus datos?',
            textAlign: TextAlign.center,
          ),
          content: Row(
            children: [
              TextButton(
                child: Text('Cancelar'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Spacer(),
              TextButton(
                  child: Text('Aceptar'),
                  onPressed: () {
                    if (ticketList != null) {
                      sqlite.DB.deleteList(ticketList).then(
                          (value) => {Navigator.pop(context), accept = true});
                    } else {
                      sqlite.DB.delete(id).then(
                          (value) => {Navigator.pop(context), accept = true});
                    }
                  }),
            ],
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        );
      });
  return accept;
}

Future<SharedPreferences?> getPrefs() async {
  prefs = await SharedPreferences.getInstance();
  return prefs;
}

void saveExcel(File? image) async {
  if (Platform.isAndroid && await requestPermission(Permission.storage)) {
    var directory = await getExternalStorageDirectory();
    imageFile = await image!.copy(directory!.path + '/Output.xlsx');
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

Future<bool> requestPermission(Permission permission) async {
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

void changePageFade(Widget destinyPage, BuildContext context) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (c, a1, a2) => destinyPage,
      transitionsBuilder: (c, anim, a2, child) =>
          FadeTransition(opacity: anim, child: child),
      transitionDuration: Duration(milliseconds: 400),
    ),
  );
}

void changePageFadeRemoveUntil(Widget destinyPage, BuildContext context) {
  Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => destinyPage,
        transitionsBuilder: (c, anim, a2, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: Duration(milliseconds: 400),
      ),
      (Route<dynamic> route) => false);
}
