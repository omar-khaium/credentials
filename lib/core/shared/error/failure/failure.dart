abstract class Failure {
  final String message;

  Failure({required this.message});

  @override
  String toString() => message;
}

class NoInternetFailure extends Failure {
  NoInternetFailure()
      : super(
          message: 'No internet connection.',
        );
}

class UnauthorizedFailure extends Failure {
  UnauthorizedFailure({
    super.message = 'Authorization expired.',
  });
}

class RemoteFailure extends Failure {
  RemoteFailure({
    super.message = 'Something went wrong at the server-end.',
  });
}

class UnknownFailure extends Failure {
  UnknownFailure({
    super.message = 'Unknown error.',
    StackTrace? stackTrace,
  });
}

class DeviceNotFoundFailure extends Failure {
  DeviceNotFoundFailure({
    super.message = 'Device not found.',
  });
}

class GoogleSignInFailure extends Failure {
  GoogleSignInFailure({
    super.message = 'Google sign in failed.',
  });
}

class GoogleAccountNotRegisteredFailure extends Failure {
  GoogleAccountNotRegisteredFailure() : super(message: 'Google account is not registered.');
}

class FacebookAccountNotRegisteredFailure extends Failure {
  FacebookAccountNotRegisteredFailure() : super(message: 'Facebook account is not registered.');
}

class AppleAccountNotRegisteredFailure extends Failure {
  AppleAccountNotRegisteredFailure() : super(message: 'Apple account is not registered.');
}
