import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/shared/error/failure/failure.dart';
import '../../domain/repositories/repo.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final FirebaseAuth auth;

  AuthenticationRepositoryImpl({
    required this.auth,
  });

  @override
  Future<Either<Failure, User>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(email: email, password: password);
      return Right(credential.user!);
    } on Failure catch (e) {
      return Left(e);
    } on FirebaseAuthException catch (e) {
      return Left(RemoteFailure(message: e.message!));
    } catch (e, stackTrace) {
      return Left(
        UnknownFailure(
          message: e.toString(),
          stackTrace: stackTrace,
        ),
      );
    }
  }
}
