part of 'hit_credential_bloc.dart';

sealed class HitCredentialEvent extends Equatable {
  const HitCredentialEvent();

  @override
  List<Object> get props => [];
}

class HitCredential extends HitCredentialEvent {
  final CredentialEntity credential;

  HitCredential({
    required this.credential,
  });
}