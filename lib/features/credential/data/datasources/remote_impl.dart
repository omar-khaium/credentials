import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credentials/core/shared/remote/endpoints.dart';
import 'package:credentials/features/credential/data/models/credential.dart';

import 'remote.dart';

class CredentialRemoteDataSourceImpl implements CredentialRemoteDataSource {
  final FirebaseFirestore firestore;

  CredentialRemoteDataSourceImpl({
    required this.firestore,
  });

  @override
  Stream<List<CredentialModel>> fetch({
    required String userId,
  }) async* {
    yield* firestore
        .collection(RemoteCollections.credentials)
        .where('createdBy', isEqualTo: userId)
        .where("isActive", isEqualTo: true)
        .orderBy("url")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map(
              (doc) => CredentialModel.parse(doc: doc),
            )
            .toList());
  }
}
