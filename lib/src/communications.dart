import 'dart:io';

import 'package:http/http.dart' as http;

/* ID cuenta: 787300768889
nombre usuario: textractUser
contraseña: Slangaws22 */

var response;

Future<bool> loginSlang(String email, String password) async {
  //Devuelve la información del usuario si existe en forma de string/json
  var headers = {'clientVersion': '0.1.16'};
  var body = {'email': email, 'password': password};
  var url = Uri.parse(
      'http://serv.slang.digital/api/client/auth/login?customres=true');

  response = await http.post(url, headers: headers, body: body);
  response = response.body;

  if (response.contains('Invalid user or password')) return false;
  return true;
}

void uploadImageToSlang(String categs, File image) async {
  var fileData = DateTime.now()
          .toString()
          .substring(0, 16)
          .replaceAll(RegExp(r' |:'), '-') +
      '.jpg|' +
      categs;

  List<int> imgBytes = await image.readAsBytes();
  var headers = {
    'utoken':
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI2MTllMzcxNGZjMjhmZTQ0OTg5NmNiYzQiLCJpYXQiOjE2MzgzNTY0MDQsImV4cCI6MTYzODM3MDgwNH0.Cpc8U7W56_lIe-pPBp2qXGEqBm3waiC_la63VuBeamA',
    'clientVersion': '0.1.7'
  };
  var request = http.MultipartRequest(
      'PUT',
      Uri.parse(
          'http://serv.slang.digital/api/client/storage/users/619e3714fc28fe449896cbc4'));
  request.files.add(await http.MultipartFile.fromPath('file', image.path));
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
}
