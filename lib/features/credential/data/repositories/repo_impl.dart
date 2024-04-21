import 'package:credentials/core/shared/error/failure/failure.dart';
import 'package:credentials/features/credential/data/datasources/remote.dart';
import 'package:credentials/features/credential/domain/repositories/repo.dart';
import 'package:either_dart/src/either.dart';
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

  @override
  Future<Either<Failure, void>> hit({
    required CredentialEntity credential,
  }) async {
    try {
      await remote.hit(credential: credential);
      return Right(null);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, void>> archive({
    required CredentialEntity credential,
  }) async {
    try {
      await remote.archive(credential: credential);
      return Right(null);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, void>> create({
    required CredentialEntity credential,
  }) async {
    try {
      await remote.create(credential: credential);
      return Right(null);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, void>> update({
    required CredentialEntity credential,
  }) async {
    try {
      await remote.update(credential: credential);
      return Right(null);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
