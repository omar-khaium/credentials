import 'package:bloc/bloc.dart';
import 'package:credentials/core/shared/error/failure/failure.dart';
import 'package:credentials/features/credential/domain/entities/credential.dart';
import 'package:credentials/features/credential/domain/usecases/fetch.dart';
import 'package:equatable/equatable.dart';

part 'credential_event.dart';
part 'credential_state.dart';

class CredentialBloc extends Bloc<CredentialEvent, CredentialState> {
  final FetchCredentialsUsecase usecase;
  CredentialBloc({
    required this.usecase,
  }) : super(CredentialInitial()) {
    on<FetchCredentials>((event, emit) async {
      emit(CredentialLoading());
      try {
        await for (var credentials in usecase()) {
          final popular = credentials.where((e) => (e.hitCount ?? 0) > 10).toList();
          popular.sort((a, b) => b.hitCount!.compareTo(a.hitCount!));

          emit(CredentialDone(
            credentials: credentials,
            popular: popular.take(10).toList(),
          ));
        }
      } on Failure catch (e) {
        emit(CredentialError(failure: e));
      }
    });
    on<SearchCredentials>((event, emit) async {
      if (state is CredentialDone) {
        final CredentialDone currentState = state as CredentialDone;
        final List<CredentialEntity> credentials = currentState.credentials;
        final List<CredentialEntity> popular = currentState.popular;
        final List<CredentialEntity> filtered =
            credentials.where((e) => e.url.toLowerCase().contains(event.query.toLowerCase())).toList();
        emit(CredentialDone(
          credentials: filtered,
          popular: popular,
        ));
      }
    });
  }
}
