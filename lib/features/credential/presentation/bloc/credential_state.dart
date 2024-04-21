part of 'credential_bloc.dart';

abstract class CredentialState extends Equatable {
  const CredentialState();

  @override
  List<Object> get props => [];
}

class CredentialInitial extends CredentialState {}

class CredentialLoading extends CredentialState {}

class CredentialError extends CredentialState {
  final Failure failure;

  CredentialError({
    required this.failure,
  });
}

class CredentialDone extends CredentialState {
  final List<CredentialEntity> popular;
  final List<CredentialEntity> credentials;
  CredentialDone({
    required this.popular,
    required this.credentials,
  });

  @override
  List<Object> get props => [credentials, popular];
}
