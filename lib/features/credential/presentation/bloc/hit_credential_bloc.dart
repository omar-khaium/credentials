import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/shared/error/failure/failure.dart';
import '../../domain/entities/credential.dart';
import '../../domain/usecases/hit.dart';

part 'hit_credential_event.dart';
part 'hit_credential_state.dart';

class HitCredentialBloc extends Bloc<HitCredentialEvent, HitCredentialState> {
  final CredentialHitUsecase usecase;
  HitCredentialBloc({
    required this.usecase,
  }) : super(HitCredentialInitial()) {
    on<HitCredential>((event, emit) async {
      emit(HitCredentialLoading());
      final result = await usecase(
        credential: event.credential,
      );
      if (!isClosed) {
        result.fold(
          (failure) => emit(HitCredentialError(failure: failure)),
          (_) => emit(HitCredentialDone()),
        );
      }
    });
  }
}
