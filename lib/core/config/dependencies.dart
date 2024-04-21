part of 'config.dart';

final sl = GetIt.instance;

Future<void> _setupDependencies() async {
  await Future.wait([
    _core,
    _authentication,
    _credentials,
  ]);
}

Future<void> get _core async {
  sl.registerFactory(
    () => ThemeBloc(),
  );

  sl.registerLazySingleton(() => Client());
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
}

Future<void> get _authentication async {
  sl.registerFactory(
    () => AuthenticationBloc(
      usecase: sl(),
    ),
  );

  sl.registerFactory(
    () => AuthenticationUsecase(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      auth: sl(),
    ),
  );
}

Future<void> get _credentials async {
  sl.registerFactory(
    () => CredentialBloc(
      usecase: sl(),
    ),
  );
  sl.registerFactory(
    () => HitCredentialBloc(
      usecase: sl(),
    ),
  );

  sl.registerFactory(
    () => FetchCredentialsUsecase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => CredentialHitUsecase(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton<CredentialRepository>(
    () => CredentialRepositoryImpl(
      auth: sl(),
      remote: sl(),
    ),
  );

  sl.registerLazySingleton<CredentialRemoteDataSource>(
    () => CredentialRemoteDataSourceImpl(
      firestore: sl(),
    ),
  );
}
