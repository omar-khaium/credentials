import 'package:credentials/features/credential/data/models/credential.dart';

abstract class CredentialRemoteDataSource {
  Stream<List<CredentialModel>> fetch({
    required String userId,
  });
}
