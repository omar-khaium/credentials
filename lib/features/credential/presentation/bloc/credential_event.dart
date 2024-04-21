part of 'credential_bloc.dart';

abstract class CredentialEvent extends Equatable {
  const CredentialEvent();

  @override
  List<Object> get props => [];
}

class FetchCredentials extends CredentialEvent {}

class SearchCredentials extends CredentialEvent {
  final String query;

  SearchCredentials({
    required this.query,
  });

  @override
  List<Object> get props => [query];
}
