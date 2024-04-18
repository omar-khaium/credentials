import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credentials/features/credential/domain/entities/credential.dart';

abstract class CredentialRepository {
  Stream<QuerySnapshot<CredentialEntity>> getCredentials();
}
