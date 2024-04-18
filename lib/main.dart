import 'package:credentials/core/shared/extension/theme.dart';
import 'package:credentials/core/shared/theme/theme_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/config/config.dart';
import 'core/shared/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  await AppConfig.init();

  runApp(
    MultiProvider(
      providers: [
        BlocProvider(create: (_) => sl<ThemeBloc>()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        return MaterialApp.router(
          title: 'Credentials',
          debugShowCheckedModeBanner: false,
          theme: AppConfig.theme(context: context, theme: state.scheme),
          routerConfig: router,
        );
      },
    );
  }
}
