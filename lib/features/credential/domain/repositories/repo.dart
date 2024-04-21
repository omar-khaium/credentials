import 'package:credentials/features/credential/domain/entities/credential.dart';
import 'package:either_dart/either.dart';

import '../../../../core/shared/error/failure/failure.dart';

abstract class CredentialRepository {
  Stream<List<CredentialEntity>> fetch();
  
  Future<Either<Failure, void>> hit({
    required CredentialEntity credential,
  });
}
