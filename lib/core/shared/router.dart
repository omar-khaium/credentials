import 'package:credentials/core/config/config.dart';
import 'package:credentials/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:credentials/features/authentication/presentation/pages/authentication.dart';
import 'package:credentials/features/credential/presentation/bloc/credential_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/dashboard/presentation/pages/dashboard.dart';

final router = GoRouter(
  initialLocation: DashboardPage.path,
  routes: [
    GoRoute(
      path: AuthenticationPage.path,
      name: AuthenticationPage.tag,
      builder: (context, state) => BlocProvider(
        create: (_) => sl<AuthenticationBloc>(),
        child: const AuthenticationPage(),
      ),
    ),
    GoRoute(
      path: DashboardPage.path,
      name: DashboardPage.tag,
      builder: (context, state) => BlocProvider(
        create: (_) => sl<CredentialBloc>(),
        child: const DashboardPage(),
      ),
    ),
  ],
);
