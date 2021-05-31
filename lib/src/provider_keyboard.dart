import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class KeyboardProvider extends ChangeNotifier {
  bool _visible = false;

  bool get visible => _visible;

  bool get hidden => !_visible;

  listen() async {
    KeyboardVisibilityController().onChange.listen((event) {
      _visible = event;
      notifyListeners();
    });
  }

  void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
