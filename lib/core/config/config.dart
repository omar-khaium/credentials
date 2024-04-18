library config;

import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credentials/core/shared/theme/scheme.dart';
import 'package:credentials/core/shared/theme/theme_bloc.dart';
import 'package:credentials/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/authentication/data/repositories/repo_impl.dart';
import '../../features/authentication/domain/repositories/repo.dart';
import '../../features/authentication/domain/usecases/sign_in_with_email_and_password.dart';
import '../../features/credential/data/datasources/remote.dart';
import '../../features/credential/data/datasources/remote_impl.dart';
import '../../features/credential/data/repositories/repo_impl.dart';
import '../../features/credential/domain/repositories/repo.dart';
import '../../features/credential/domain/usecases/fetch.dart';
import '../../features/credential/presentation/bloc/credential_bloc.dart';
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
  }

  static ThemeData theme({
    required BuildContext context,
    required ThemeScheme theme,
  }) =>
      ThemeData(
        brightness: Brightness.light,
        canvasColor: theme.background,
        shadowColor: theme.shadow,
        indicatorColor: theme.accent,
        splashColor: theme.tag,
        highlightColor: theme.highlight,
        splashFactory: InkRipple.splashFactory,
        dividerColor: theme.shadow,
        dividerTheme: DividerThemeData(color: theme.shadow, space: 1, thickness: 1),
        primaryColor: theme.accent,
        progressIndicatorTheme: ProgressIndicatorThemeData(color: theme.accent),
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          filled: true,
          fillColor: theme.card,
          labelStyle: TextStyles.body(context: context, color: theme.text),
          contentPadding: const EdgeInsets.all(16.0),
          hintStyle: TextStyles.body(context: context, color: theme.hint),
          errorStyle: TextStyles.caption(context: context, color: theme.error).copyWith(height: 0, fontSize: 0),
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
            borderSide: BorderSide(color: theme.error, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: theme.error, width: 3),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 1,
            shadowColor: theme.shadow,
            padding: const EdgeInsets.all(16),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: theme.accent,
            elevation: 3,
            shadowColor: theme.shadow,
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
          actionsIconTheme: IconThemeData(color: theme.accent),
          backgroundColor: theme.background,
          surfaceTintColor: theme.background,
          elevation: 0,
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: theme.accent,
        ).copyWith(background: theme.background),
      );
}
