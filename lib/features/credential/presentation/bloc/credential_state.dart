part of 'credential_bloc.dart';

abstract class CredentialState extends Equatable {
  const CredentialState();  

  @override
  List<Object> get props => [];
}
class CredentialInitial extends CredentialState {}
