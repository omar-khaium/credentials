import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credentials/core/shared/extension/credential.dart';
import 'package:credentials/core/shared/remote/endpoints.dart';
import 'package:credentials/features/credential/data/models/credential.dart';

import '../../domain/entities/credential.dart';
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

  @override
  Future<void> hit({
    required CredentialEntity credential,
  }) async {
    final updatedCopy = credential.copyWith(
      hitCount: (credential.hitCount ?? 0) + 1,
    );
    await firestore
        .collection(
          RemoteCollections.credentials,
        )
        .doc(credential.id)
        .update(
          updatedCopy.toMap(),
        );
    return;
  }

  @override
  Future<void> archive({
    required CredentialEntity credential,
  }) async {
    final updatedCopy = credential.copyWith(
      isActive: false,
    );
    await firestore
        .collection(
          RemoteCollections.credentials,
        )
        .doc(credential.id)
        .update(
          updatedCopy.toMap(),
        );
    return;
  }

  @override
  Future<void> create({
    required CredentialEntity credential,
  }) async {
    await firestore
        .collection(
          RemoteCollections.credentials,
        )
        .add(
          credential.toCreateMap(),
        );
    return;
  }

  @override
  Future<void> update({
    required CredentialEntity credential,
  }) async {
    await firestore
        .collection(
          RemoteCollections.credentials,
        )
        .doc(credential.id)
        .update(
          credential.toMap(),
        );
    return;
  }
}
