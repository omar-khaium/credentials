part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationError extends AuthenticationState {
  final Failure failure;

  const AuthenticationError({
    required this.failure,
  });
}

class AuthenticationDone extends AuthenticationState {
  final User user;

  const AuthenticationDone({
    required this.user,
  });
}
