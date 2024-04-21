part of 'update_credential_bloc.dart';

sealed class UpdateCredentialState extends Equatable {
  const UpdateCredentialState();
  
  @override
  List<Object> get props => [];
}

class UpdateCredentialInitial extends UpdateCredentialState {}

class UpdateCredentialLoading extends UpdateCredentialState {}

class UpdateCredentialError extends UpdateCredentialState {
  final Failure failure;
  UpdateCredentialError({
    required this.failure,
  });
}

class UpdateCredentialDone extends UpdateCredentialState {
  const UpdateCredentialDone();
}
