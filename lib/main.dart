import 'src/provider_keyboard.dart';
import 'src/utils/services/auth_service.dart';
import 'src/view/routes/route_archive.dart';
import 'src/view/routes/route_auth.dart';
import 'src/view/routes/route_dashboard.dart';
import 'src/view/routes/route_register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => KeyboardProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Credentials',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LauncherRoute(),
      routes: {
        AuthRoute().route: (context) => AuthRoute(),
        RegisterRoute().route: (context) => RegisterRoute(),
        DashboardRoute().route: (context) => DashboardRoute(),
        ArchiveRoute().route: (context) => ArchiveRoute(),
      },
    );
  }
}

class LauncherRoute extends StatefulWidget {
  @override
  _LauncherRouteState createState() => _LauncherRouteState();
}

class _LauncherRouteState extends State<LauncherRoute> {
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    if (_authService.isAuthorized) {
      Navigator.of(context).pushReplacementNamed(DashboardRoute().route);
    } else {
      _authService.auth.authStateChanges().listen((user) {
        if (user != null) {
          Navigator.of(context).pushReplacementNamed(DashboardRoute().route);
        } else {
          Navigator.of(context).pushReplacementNamed(AuthRoute().route);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
