part of 'hit_credential_bloc.dart';

sealed class HitCredentialState extends Equatable {
  const HitCredentialState();

  @override
  List<Object> get props => [];
}

class HitCredentialInitial extends HitCredentialState {}

class HitCredentialLoading extends HitCredentialState {}

class HitCredentialError extends HitCredentialState {
  final Failure failure;
  HitCredentialError({
    required this.failure,
  });
}

class HitCredentialDone extends HitCredentialState {
  const HitCredentialDone();
}
