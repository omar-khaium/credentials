import 'package:credentials/features/credential/domain/entities/credential.dart';
import 'package:either_dart/either.dart';

import '../../../../core/shared/error/failure/failure.dart';
import '../repositories/repo.dart';

class CredentialHitUsecase {
  final CredentialRepository repository;

  CredentialHitUsecase({
    required this.repository,
  });

  Future<Either<Failure, void>> call({
    required CredentialEntity credential,
  }) async {
    return repository.hit(
      credential: credential,
    );
  }
}
