library config;

import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credentials/core/shared/theme/scheme.dart';
import 'package:credentials/core/shared/theme/theme_bloc.dart';
import 'package:credentials/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:credentials/features/credential/domain/usecases/add.dart';
import 'package:credentials/features/credential/domain/usecases/hit.dart';
import 'package:credentials/features/credential/presentation/bloc/hit_credential_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/authentication/data/repositories/repo_impl.dart';
import '../../features/authentication/domain/repositories/repo.dart';
import '../../features/authentication/domain/usecases/forgot_password.dart';
import '../../features/authentication/domain/usecases/sign_in_with_email_and_password.dart';
import '../../features/authentication/domain/usecases/sign_up_with_email_and_password.dart';
import '../../features/authentication/presentation/bloc/forgot_password_bloc.dart';
import '../../features/authentication/presentation/bloc/registration_bloc.dart';
import '../../features/credential/data/datasources/remote.dart';
import '../../features/credential/data/datasources/remote_impl.dart';
import '../../features/credential/data/repositories/repo_impl.dart';
import '../../features/credential/domain/repositories/repo.dart';
import '../../features/credential/domain/usecases/archive.dart';
import '../../features/credential/domain/usecases/fetch.dart';
import '../../features/credential/domain/usecases/update.dart';
import '../../features/credential/presentation/bloc/archive_credential_bloc.dart';
import '../../features/credential/presentation/bloc/create_credential_bloc.dart';
import '../../features/credential/presentation/bloc/credential_bloc.dart';
import '../../features/credential/presentation/bloc/update_credential_bloc.dart';
import '../../firebase_options.dart';
import '../shared/shared.dart';

part 'dependencies.dart';
part 'network_certificates.dart';

class AppConfig {
  static FutureOr<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Bypass the SSL certificate verification
    HttpOverrides.global = MyHttpOverrides();

    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb ? HydratedStorage.webStorageDirectory : await getApplicationCacheDirectory(),
    );

    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    // Initialize the configurations
    await _setupDependencies();

    await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);

    await FirebaseAuth.instance.authStateChanges().first;

    usePathUrlStrategy();
  }

  static ThemeData theme({
    required BuildContext context,
    required ThemeScheme theme,
  }) =>
      ThemeData(
        brightness: Brightness.light,
        canvasColor: theme.background,
        shadowColor: theme.tertiary,
        indicatorColor: theme.secondary,
        splashColor: theme.tertiary,
        highlightColor: theme.secondary,
        splashFactory: InkRipple.splashFactory,
        dividerColor: theme.tertiary,
        dividerTheme: DividerThemeData(color: theme.tertiary, space: 1, thickness: 1),
        primaryColor: theme.primary,
        progressIndicatorTheme: ProgressIndicatorThemeData(color: theme.primary),
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          filled: true,
          fillColor: theme.tertiary,
          labelStyle: TextStyles.body(context: context, color: theme.text),
          contentPadding: const EdgeInsets.all(16.0),
          hintStyle: TextStyles.body(context: context, color: theme.text.withAlpha(125)),
          errorStyle: TextStyles.caption(context: context, color: theme.primary).copyWith(height: 0, fontSize: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.black, width: .5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.black, width: 4),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: theme.primary, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: theme.primary, width: 3),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 1,
            shadowColor: theme.primary,
            padding: const EdgeInsets.all(16),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: theme.primary,
            elevation: 3,
            shadowColor: theme.tertiary,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        textSelectionTheme: TextSelectionThemeData(cursorColor: theme.text),
        iconTheme: IconThemeData(color: theme.text, size: 20),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          iconTheme: const IconThemeData(color: Colors.black),
          titleSpacing: 0,
          actionsIconTheme: IconThemeData(color: theme.primary),
          backgroundColor: theme.background,
          surfaceTintColor: theme.background,
          elevation: 0,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: theme.primary,
        ).copyWith(background: theme.background),
      );
}
