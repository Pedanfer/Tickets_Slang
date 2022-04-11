<<<<<<< HEAD:lib/src/Google.dart
// ignore_for_file: unused_element
=======
import 'dart:io';
>>>>>>> origin/main:lib/src/functions/Google.dart

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:googleapis/drive/v3.dart' as drive;

bool _loginStatus = false;
final googleSignIn = GoogleSignIn.standard(scopes: [
  drive.DriveApi.driveAppdataScope,
  drive.DriveApi.driveFileScope,
]);

Future<void> signIn() async {
  print('Entra');
  final googleUser = await googleSignIn.signIn();
print('USUARIO' + googleUser.toString());
  try {
    if (googleUser != null) {
      print('No es nulo');
      final googleAuth = await googleUser.authentication;
      print('PC1');
      final credential = GoogleAuthProvider.credential(
        
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
            print('PC2');
      final loginUser =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print('PC3');
      assert(loginUser.user?.uid == FirebaseAuth.instance.currentUser?.uid);
      print('Sign in');
      _loginStatus = true;
    }
  } catch (e) {
    print('----------------------------Error en login----------------------------');
    print(e);
    print('----------------------------------------------------------------------');
  }
  print(_loginStatus);
}

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
  await googleSignIn.signOut();
  _loginStatus = false;
  print('Sign out');
}

/*
// GOOGLE DRIVE

Future<drive.DriveApi?> _getDriveApi() async {
  final googleUser = await googleSignIn.signIn();
  final headers = await googleUser?.authHeaders;
  if (headers == null) {
    await showMessage(context, 'Sign-in first', 'Error');
    return null;
  }

  final client = GoogleAuthClient(headers);
  final driveApi = drive.DriveApi(client);
  return driveApi;
}

class GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;
  final _client = new http.Client();

  GoogleAuthClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(_headers);
    return _client.send(request);
  }
}

Future<void> _uploadToHidden() async {
  try {
    final driveApi = await _getDriveApi();
    if (driveApi == null) {
      return;
    }
    // Not allow a user to do something else
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: Duration(seconds: 2),
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (context, animation, secondaryAnimation) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    ...
  } finally {
    // Remove a dialog
    Navigator.pop(context);
  }
}

// Create data here instead of loading a file
final contents = 'Technical Feeder';
final Stream<List<int>> mediaStream =
    Future.value(contents.codeUnits).asStream().asBroadcastStream();
var media = new drive.Media(mediaStream, contents.length);

// Set up File info
var driveFile = new drive.File();
final timestamp = DateFormat('yyyy-MM-dd-hhmmss').format(DateTime.now());
driveFile.name = 'technical-feeder-$timestamp.txt';
driveFile.modifiedTime = DateTime.now().toUtc();
driveFile.parents = ['appDataFolder'];

// Upload
final response = await driveApi.files.create(driveFile, uploadMedia: media);




// --------------------------------
// Get file list from hidden folder
// --------------------------------

Future<void> _showList() async {
  final driveApi = await _getDriveApi();
  if (driveApi == null) {
    return;
  }

  final fileList = await driveApi.files.list(
      spaces: 'appDataFolder', $fields: 'files(id, name, modifiedTime)');
  final files = fileList.files;
  if (files == null) {
    return showMessage(context, 'Data not found', '');
  }

  final alert = AlertDialog(
    title: Text('Item List'),
    content: SingleChildScrollView(
      child: ListBody(
        children: files.map((e) => Text(e.name ?? 'no-name')).toList(),
      ),
    ),
  );

  return showDialog(
    context: context,
    builder: (BuildContext context) => alert,
  );
}

// ----------------------------
// Upload data to normal folder
// ----------------------------

final googleSignIn = GoogleSignIn.standard(scopes: [
  drive.DriveApi.driveFileScope,
]);

//--------If it is not specified there, the following error occurs. ------
// I/flutter ( 6132): DetailedApiRequestError(status: 403, message: The granted scopes do not give access to all of the requested spaces.)



// -------------------------------------------------------------
// Check if a folder exists in Google Drive, otherwise create it
// -------------------------------------------------------------

Future<String?> _getFolderId(drive.DriveApi driveApi) async {
  final mimeType = 'application/vnd.google-apps.folder';
  var folderName = 'Flutter-sample-by-tf';

  try {
    final found = await driveApi.files.list(
      q: "mimeType = '$mimeType' and name = '$folderName'",
      $fields: 'files(id, name)',
    );
    final files = found.files;
    if (files == null) {
      await showMessage(context, 'Sign-in first', 'Error');
      return null;
    }

    // The folder already exists
    if (files.isNotEmpty) {
      return files.first.id;
    }

    // Create a folder
    var folder = new drive.File();
    folder.name = folderName;
    folder.mimeType = mimeType;
    final folderCreation = await driveApi.files.create(folder);
    print('Folder ID: ${folderCreation.id}');

    return folderCreation.id;
  } catch (e) {
    print(e);
    return null;
  }
}




// ------------------------------------
// Upload a file to the specific folder
// ------------------------------------


Future<void> _uploadToNormal() async {
  try {
    //...
    
    // Check if the folder exists. If it doesn't exist, create it and return the ID.
    final folderId = await _getFolderId(driveApi);
    if (folderId == null) {
      await showMessage(context, 'Failure', 'Error');
      return;
    }

    // Create data here instead of loading a file
    final contents = 'Technical Feeder';
    final mediaStream =
        Future.value(contents.codeUnits).asStream().asBroadcastStream();
    var media = new drive.Media(mediaStream, contents.length);

    // Set up File info
    var driveFile = new drive.File();
    final timestamp = DateFormat('yyyy-MM-dd-hhmmss').format(DateTime.now());
    driveFile.name = 'technical-feeder-$timestamp.txt';
    driveFile.modifiedTime = DateTime.now().toUtc();

    // !!!!!! Set the folder ID here !!!!!!!!!!!!
    driveFile.parents = [folderId];

    // Upload
    final response =
        await driveApi.files.create(driveFile, uploadMedia: media);
    print('response: $response');

    // simulate a slow process
    await Future.delayed(Duration(seconds: 2));
  } finally {
    // Remove a dialog
    Navigator.pop(context);
  }
}*/