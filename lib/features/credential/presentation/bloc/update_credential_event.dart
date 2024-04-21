part of 'update_credential_bloc.dart';

sealed class UpdateCredentialEvent extends Equatable {
  const UpdateCredentialEvent();

  @override
  List<Object> get props => [];
}

class UpdateCredential extends UpdateCredentialEvent {
  final CredentialEntity credential;

  UpdateCredential({
    required this.credential,
  });
}
