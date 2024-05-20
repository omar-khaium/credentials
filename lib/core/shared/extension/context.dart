import 'package:credentials/core/shared/extension/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/credential/presentation/bloc/credential_bloc.dart';
import '../shared.dart';
import '../theme/theme_bloc.dart';

extension BuildContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  double get topInset => MediaQuery.of(this).padding.top;

  double get bottomInset => MediaQuery.of(this).padding.bottom;

  double get smallestSide => MediaQuery.of(this).size.shortestSide;
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;

  ScaffoldMessengerState successNotification({
    required String message,
  }) {
    final theme = themeBloc.state.scheme;
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyles.body(context: this, color: theme.background),
      ),
      backgroundColor: theme.tertiary,
    );
    return ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  ScaffoldMessengerState errorNotification({
    required String message,
  }) {
    final theme = themeBloc.state.scheme;
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyles.body(context: this, color: theme.background),
      ),
      backgroundColor: theme.secondary,
    );
    return ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  ScaffoldMessengerState warningNotification({
    required String message,
  }) {
    final theme = themeBloc.state.scheme;
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyles.body(context: this, color: theme.background),
      ),
      backgroundColor: theme.tertiary,
    );
    return ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  ThemeBloc get themeBloc => read<ThemeBloc>();

  CredentialBloc get credentialBloc => read<CredentialBloc>();

  bool get isMobile {
    final size = MediaQuery.of(this).size;
    return size.width < 600;
  }
}
