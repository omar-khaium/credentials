part of 'config.dart';

final sl = GetIt.instance;

Future<void> _setupDependencies() async {
  await Future.wait([
    _core,
    _authentication,
  ]);
}

Future<void> get _core async {
  sl.registerFactory(
    () => ThemeBloc(),
  );

  sl.registerLazySingleton(() => Client());
  sl.registerLazySingleton(() => FirebaseAuth.instance);
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
