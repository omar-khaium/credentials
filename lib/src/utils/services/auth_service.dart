import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> signInAnonymously() async {
    try {
      final UserCredential credential = await auth.signInAnonymously();
      return credential != null;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      final facebookAuthCredential = FacebookAuthProvider.credential(result.accessToken.token);

      final UserCredential credential = await auth.signInWithCredential(facebookAuthCredential);
      return credential != null;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> signInWithEmail(String username, String password) async {
    try {
      final UserCredential credential = await auth.signInWithEmailAndPassword(email: username, password: password);
      return credential != null;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      await auth.signOut();
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  bool get isAuthorized => auth.currentUser != null;

  User get currentUser => auth.currentUser;
}
