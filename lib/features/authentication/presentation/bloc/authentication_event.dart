part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class Authenticate extends AuthenticationEvent {
  final String email;
  final String password;

  const Authenticate({
    required this.email,
    required this.password,
  });
}