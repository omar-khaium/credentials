import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credentials/src/model/credential.dart';
import 'package:credentials/src/utils/constants.dart';

class ApiService {
  FirebaseFirestore instance = FirebaseFirestore.instance;
  List<DocumentSnapshot> list;

  Future<bool> addCredential(Credential credential) async {
    try {
      final DocumentReference reference = await instance.collection(credentialCollection).add(credential.toCreateMap);
      return reference != null;
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
