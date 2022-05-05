import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart' as signIn;
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:slang_mobile/src/tickets/utils/constants.dart';

var signInData;

class GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;
  final http.Client _client = new http.Client();
  GoogleAuthClient(this._headers);

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _client.send(request..headers.addAll(_headers));
  }
}

Future<void> signInDrive() async {
  signInData = await signIn.GoogleSignIn.standard(
      scopes: [drive.DriveApi.driveFileScope]).signIn();
}

Future<void> signOutDrive() async {
  signInData = await signIn.GoogleSignIn.standard().disconnect();
}

Future<void> uploadFile() async {
  var authHeaders = await signInData.authHeaders;
  var authenticateClient = GoogleAuthClient(authHeaders);
  var driveApi = drive.DriveApi(authenticateClient);
  var zipFile = File(ticketsZipPath);
  final Stream<List<int>> mediaStream = await zipFile.openRead();
  var media = new drive.Media(mediaStream, zipFile.lengthSync());
  var driveFile = new drive.File();
  driveFile.name = "Tickets.zip";
  await driveApi.files.create(driveFile, uploadMedia: media);
}

/*
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

Future<void> _uploadToNormal() async {
  try {        
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