part of 'create_credential_bloc.dart';

sealed class CreateCredentialState extends Equatable {
  const CreateCredentialState();
  
  @override
  List<Object> get props => [];
}

class CreateCredentialInitial extends CreateCredentialState {}

class CreateCredentialLoading extends CreateCredentialState {}

class CreateCredentialError extends CreateCredentialState {
  final Failure failure;
  CreateCredentialError({
    required this.failure,
  });
}

class CreateCredentialDone extends CreateCredentialState {
  const CreateCredentialDone();
}
