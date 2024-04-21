part of 'registration_bloc.dart';

sealed class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class Register extends RegistrationEvent {
  final String email;
  final String password;

  const Register({
    required this.email,
    required this.password,
  });
}