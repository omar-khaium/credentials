import 'package:credentials/src/provider_keyboard.dart';
import 'package:credentials/src/utils/services/auth_service.dart';
import 'package:credentials/src/view/routes/route_archive.dart';
import 'package:credentials/src/view/routes/route_auth.dart';
import 'package:credentials/src/view/routes/route_dashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    FacebookAuth.instance.webInitialize(
      appId: "190883392903715",
      cookie: true,
      xfbml: true,
      version: "v10.0",
    );
  }
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => KeyboardProvider()),
    ],
    child: MyApp(),
  ));
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
    Future.delayed(Duration(milliseconds: 1), () {
      if (_authService.isAuthorized && ModalRoute.of(context).isFirst) {
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
    });
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
