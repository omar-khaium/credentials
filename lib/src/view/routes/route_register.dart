import 'package:credentials/src/provider_keyboard.dart';
import 'package:credentials/src/view/widgets/register/form_web.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterRoute extends StatefulWidget {
  final String route = "/register";

  @override
  _RegisterRouteState createState() => _RegisterRouteState();
}

class _RegisterRouteState extends State<RegisterRoute> {
  @override
  Widget build(BuildContext context) {
    final keyboardProvider = Provider.of<KeyboardProvider>(context);
    keyboardProvider.listen();

    return Scaffold(
      body: WebRegisterForm(),
    );
  }
}
