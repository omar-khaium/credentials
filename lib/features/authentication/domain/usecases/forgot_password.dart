import 'package:either_dart/either.dart';
import 'package:credentials/core/shared/error/failure/failure.dart';
import 'package:credentials/features/authentication/domain/repositories/repo.dart';

class ForgotPasswordUsecase {
  final AuthenticationRepository repository;

  ForgotPasswordUsecase({
    required this.repository,
  });

  Future<Either<Failure, void>> call({
    required String email,
  }) async {
    return repository.forgotPassword(
      email: email,
    );
  }
}
