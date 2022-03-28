// ignore_for_file: unused_local_variable, omit_local_variable_types

import 'dart:io';
import 'dart:convert';
import 'package:exploration_planner/src/utilidades.dart';
import 'package:http/http.dart' as http;

/* ID cuenta: 787300768889
nombre usuario: textractUser
contraseña: Slangaws22 */

Future<bool> loginSlang(String email, String password) async {
  //Devuelve la información del usuario si existe en forma de string/json
  var headers = {'clientVersion': '0.1.16'};
  var body = {'email': email, 'password': password};
  var url = Uri.parse(
      'http://serv.slang.digital/api/client/auth/login?customres=true');

  var response = await http.post(url, headers: headers, body: body);

  var jsonData = await json.decode(response.body);
  await getPrefs()
      .then((value) => value!.setString('jsonData', json.encode(jsonData)));

  if (response.body.contains('Invalid user or password')) return false;
  return true;
}

void uploadImageToSlang(String categs, File image) async {
  var jsonData;
  var headers;
  http.MultipartRequest? request;
  await getPrefs().then((value) async => {
        jsonData = json.decode(value!.getString('jsonData')!),
        headers = {
          'utoken': jsonData['token'] as String,
          'clientVersion': '0.1.16'
        },
        request = http.MultipartRequest(
            'PUT',
            Uri.parse('http://serv.slang.digital/api/client/storage/users/' +
                jsonData['userData']['uid'])),
        request!.files
            .add(await http.MultipartFile.fromPath('file', image.path)),
        request!.headers.addAll(headers),
      });

  http.StreamedResponse response = await request!.send();
  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}
