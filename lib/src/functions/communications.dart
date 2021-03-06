// ignore_for_file: unused_local_variable, omit_local_variable_types

import 'dart:io';
import 'dart:convert';
import 'package:slang_mobile/src/functions/utilidades.dart';
import 'package:http/http.dart' as http;
import 'package:slang_mobile/main.dart';

Future<bool> loginSlang(String email, String password) async {
  var headers = {'clientVersion': '0.1.16'};
  var body = {'email': email, 'password': password};
  var url = Uri.parse(
      'http://serv.slang.digital/api/client/auth/login?customres=true');

  var response = await http.post(url, headers: headers, body: body);
  var jsonData = await json.decode(response.body);

  await getPrefs()
      .then((value) => prefs!.setString('jsonData', json.encode(jsonData)));

  if (response.body.contains('Invalid user or password')) return false;
  return true;
}

Future<Map<String, dynamic>> uploadImageToSlang(File image) async {
  var jsonData;
  var headers;
  http.MultipartRequest? request;
  await getPrefs().then((value) async => {
        jsonData = json.decode(prefs!.getString('jsonData')!),
        headers = {
          'utoken': jsonData['token'] as String,
          'clientVersion': '0.1.16'
        },
        request = http.MultipartRequest(
            'POST',
            Uri.parse(
                'http://serv.slang.digital/api/client/tools/textract?doctype=invoiceticket')),
        request!.files
            .add(await http.MultipartFile.fromPath('file', image.path)),
        request!.headers.addAll(headers)
      });
  var response = await http.Response.fromStream(await request!.send());
  jsonData = await json.decode(response.body);
  return jsonData;
}

Future<bool> registerSlang(String name, String email, String password) async {
  var headers = {'clientVersion': '0.1.16'};
  var body = {
    'email': email,
    'name': name,
    'password': password,
  };
  var url = Uri.parse('http://serv.slang.digital/api/client/users');
  var response = await http.post(url, headers: headers, body: body);
  return true;
}
