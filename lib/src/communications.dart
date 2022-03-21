import 'package:http/http.dart' as http;

Future<bool> loginSlang(String email, String password) async {
  //Devuelve la información del usuario si existe en forma de string/json
  var headers = {'clientVersion': '0.1.16'};
  var body = {'email': email, 'password': password};
  var url = Uri.parse(
      'http://serv.slang.digital/api/client/auth/login?customres=true');

  var response = await http.post(url, headers: headers, body: body);

  if (response.body.contains('Invalid user or password')) return false;
  return true;
}
