part of 'archive_credential_bloc.dart';

sealed class ArchiveCredentialEvent extends Equatable {
  const ArchiveCredentialEvent();

  @override
  List<Object> get props => [];
}

class ArchiveCredential extends ArchiveCredentialEvent {
  final CredentialEntity credential;

  ArchiveCredential({
    required this.credential,
  });
}