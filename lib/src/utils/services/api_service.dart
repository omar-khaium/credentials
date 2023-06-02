import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/credential.dart';
import '../constants.dart';

class ApiService {
  FirebaseFirestore instance = FirebaseFirestore.instance;

  Future<bool> addCredential(Credential credential) async {
    try {
      await instance.collection(credentialCollection).add(credential.toCreateMap);
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> editCredential(Credential credential) async {
    try {
      await instance.collection(credentialCollection).doc(credential.id).update(credential.toEditMap);
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> deleteCredential(String id) async {
    try {
      await instance.collection(credentialCollection).doc(id).delete();
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
