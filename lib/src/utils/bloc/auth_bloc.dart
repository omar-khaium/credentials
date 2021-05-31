import 'dart:async';

import 'package:credentials/src/utils/services/auth_service.dart';

class AuthBLoC {
  final AuthService _authService = AuthService();

  final StreamController _authStatusController = StreamController();

  StreamSink<bool> get authStatusSink => _authStatusController.sink;

  Stream get authStatusStream => _authStatusController.stream;

  AuthBLoC() {}

  void dispose() {
    _authStatusController.close();
  }
}
