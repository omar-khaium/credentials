part of 'registration_bloc.dart';

sealed class RegistrationState extends Equatable {
  const RegistrationState();
  
  @override
  List<Object> get props => [];
}

class RegistrationInitial extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}

class RegistrationError extends RegistrationState {
  final Failure failure;

  const RegistrationError({
    required this.failure,
  });
}

class RegistrationDone extends RegistrationState {
  final User user;

  const RegistrationDone({
    required this.user,
  });
}
