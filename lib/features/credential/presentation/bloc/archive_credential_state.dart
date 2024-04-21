part of 'archive_credential_bloc.dart';

sealed class ArchiveCredentialState extends Equatable {
  const ArchiveCredentialState();
  
  @override
  List<Object> get props => [];
}

class ArchiveCredentialInitial extends ArchiveCredentialState {}

class ArchiveCredentialLoading extends ArchiveCredentialState {}

class ArchiveCredentialError extends ArchiveCredentialState {
  final Failure failure;
  ArchiveCredentialError({
    required this.failure,
  });
}

class ArchiveCredentialDone extends ArchiveCredentialState {
  const ArchiveCredentialDone();
}
