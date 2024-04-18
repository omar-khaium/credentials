import 'package:credentials/features/credential/domain/entities/credential.dart';

import '../repositories/repo.dart';

class FetchCredentialsUsecase {
  final CredentialRepository repository;

  FetchCredentialsUsecase({
    required this.repository,
  });

  Stream<List<CredentialEntity>> call() async* {
    yield* repository.fetch();
  }
}
