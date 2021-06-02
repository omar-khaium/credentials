import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  Future<bool> signInWithEmail(BuildContext context, String username, String password) async {
    try {
      showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator()), barrierDismissible: false);
      final UserCredential credential = await auth.signInWithEmailAndPassword(email: username, password: password);
      Navigator.of(context).pop();
      return credential != null;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context).pop();
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Opps", style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.red)),
                content: Text(error.message.toString(), style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.red)),
              ));
      return false;
    }
  }

  Future<bool> signUpWithEmail(BuildContext context, String username, String password) async {
    try {
      showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator()), barrierDismissible: false);
      final UserCredential credential = await auth.createUserWithEmailAndPassword(email: username, password: password);
      await credential.user.sendEmailVerification();
      return credential.user != null;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context).pop();
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Opps", style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.red)),
                content: Text(error.message.toString(), style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.red)),
              ));
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
