part of 'create_credential_bloc.dart';

sealed class CreateCredentialEvent extends Equatable {
  const CreateCredentialEvent();

  @override
  List<Object> get props => [];
}

class CreateCredential extends CreateCredentialEvent {
  final CredentialEntity credential;

  CreateCredential({
    required this.credential,
  });
}