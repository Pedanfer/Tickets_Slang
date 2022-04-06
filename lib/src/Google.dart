import 'package:googleapis/drive/v3.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

bool _loginStatus = false;

/*
Future<void> _signIn() async {
  final googleUser = await GoogleSignIn.signIn();

  try {
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final loginUser =
          await FirebaseAuth.instance.signInWithCredential(credential);

      assert(loginUser.user?.uid == FirebaseAuth.instance.currentUser?.uid);
      print('Sign in');
      _loginStatus = true;
    }
  } catch (e) {
    print(e);
  }
}


Future<void> _signOut() async {
  await FirebaseAuth.instance.signOut();
  await GoogleSignIn.signOut();
  _loginStatus = false;
  print('Sign out');
}*/