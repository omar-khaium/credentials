import 'package:either_dart/either.dart';
import 'package:credentials/core/shared/error/failure/failure.dart';
import 'package:credentials/features/authentication/domain/repositories/repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationUsecase {
  final AuthenticationRepository repository;

  RegistrationUsecase({
    required this.repository,
  });

  Future<Either<Failure, User>> call({
    required String email,
    required String password,
  }) async {
    return repository.signUpWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
