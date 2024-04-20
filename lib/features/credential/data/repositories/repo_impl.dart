import 'package:credentials/features/credential/data/datasources/remote.dart';
import 'package:credentials/features/credential/domain/repositories/repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/credential.dart';

class CredentialRepositoryImpl extends CredentialRepository {
  final FirebaseAuth auth;
  final CredentialRemoteDataSource remote;

  CredentialRepositoryImpl({
    required this.auth,
    required this.remote,
  });

  @override
  Stream<List<CredentialEntity>> fetch() {
    final String userId = auth.currentUser?.uid ?? "";
    return remote.fetch(userId: userId);
  }
}
