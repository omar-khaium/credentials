part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgotPassword extends ForgotPasswordEvent {
  final String email;

  const ForgotPassword({
    required this.email,
  });
}