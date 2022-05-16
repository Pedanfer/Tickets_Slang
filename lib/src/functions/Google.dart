import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart' as signIn;
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slang_mobile/src/functions/utilidades.dart';
import 'package:path_provider/path_provider.dart';

SharedPreferences? preferences;

class GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;
  final http.Client _client = new http.Client();
  GoogleAuthClient(this._headers);

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _client.send(request..headers.addAll(_headers));
  }
}

Future<void> signInDrive() async {
  /* ¿Guardar con un diccionario los datos de cada usuario? 
  Al final estarán en la API Rest */
  var signInData = await signIn.GoogleSignIn.standard(
      scopes: [drive.DriveApi.driveFileScope]).signIn();
  getPrefs().then((value) => {
        value!.setStringList(
          'driveUserData',
          [signInData!.displayName!, signInData.email],
        ),
      });
}

Future<void> signOutDrive() async {
  await signIn.GoogleSignIn.standard().disconnect();
}

Future<void> uploadFiles() async {
  var driveApi = await refreshAuthentication();
  await createSlangFolder(driveApi);
  createFolder(driveApi).then((value) async {
    var dir = await getExternalStorageDirectory();
    var entities = await dir!.list().toList();
    var dirFiles = List<File>.from(entities);
    for (File file in dirFiles) {
      var extension = file.path.split('.').last;
      if (extension != 'zip') {
        final Stream<List<int>> mediaStream = await file.openRead();
        var media = new drive.Media(mediaStream, file.lengthSync());
        var driveFile = new drive.File();
        driveFile.name = 'Tickets.' + extension;
        driveFile.parents = [value];
        await driveApi.files.create(driveFile, uploadMedia: media);
      }
    }
    await emptyAppDir();
  });
}

Future<drive.DriveApi> refreshAuthentication() async {
  var signInGoogle = signIn.GoogleSignIn(
      signInOption: signIn.SignInOption.standard,
      scopes: [drive.DriveApi.driveFileScope],
      clientId: signIn.GoogleSignIn.standard().clientId);
  var silentSign = await signInGoogle.signInSilently();
  var silentHeaders = await silentSign!.authHeaders;
  Map<String, String> authHeaders = {
    'Authorization': silentHeaders['Authorization']!,
    'X-Goog-AuthUser': silentHeaders['X-Goog-AuthUser'] as String
  };
  var authenticateClient = GoogleAuthClient(authHeaders);
  return drive.DriveApi(authenticateClient);
}

Future<String> createFolder(drive.DriveApi driveApi) async {
  try {
    var folder = new drive.File();
    var folderID;
    folder.name = DateTime.now().toString().substring(0, 19);
    folder.parents = [preferences!.getString('slangFolderID')!];
    folder.mimeType = 'application/vnd.google-apps.folder';
    await driveApi.files.create(folder).then((value) => folderID = value.id);
    return folderID;
  } catch (e) {
    return e.toString();
  }
}

Future<void> createSlangFolder(drive.DriveApi driveApi) async {
  SharedPreferences.getInstance().then(
    (value) async {
      preferences = value;
      if (preferences!.getString('slangFolderID') == null) {
        try {
          var folder = new drive.File();
          var folderName = 'Tickets_Slang';
          folder.name = folderName;
          folder.mimeType = 'application/vnd.google-apps.folder';
          await driveApi.files.create(folder).then(
              (value) => preferences!.setString('slangFolderID', value.id!));
        } catch (e) {
          print(e);
        }
      }
    },
  );
}
