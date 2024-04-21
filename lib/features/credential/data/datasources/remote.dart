import 'package:credentials/features/credential/data/models/credential.dart';
import 'package:credentials/features/credential/domain/entities/credential.dart';

abstract class CredentialRemoteDataSource {
  Stream<List<CredentialModel>> fetch({
    required String userId,
  });
  Future<void> hit({
    required CredentialEntity credential,
  });
}
