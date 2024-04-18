import 'package:credentials/features/credential/domain/entities/credential.dart';

abstract class CredentialRepository {
  Stream<List<CredentialEntity>> fetch();
}
