import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/shared/error/failure/failure.dart';
import '../../domain/entities/credential.dart';
import '../../domain/usecases/update.dart';

part 'update_credential_event.dart';
part 'update_credential_state.dart';

class UpdateCredentialBloc extends Bloc<UpdateCredentialEvent, UpdateCredentialState> {
  final UpdateCredentialUsecase usecase;
  UpdateCredentialBloc({
    required this.usecase,
  }) : super(UpdateCredentialInitial()) {
    on<UpdateCredential>((event, emit) async {
      emit(UpdateCredentialLoading());
      final result = await usecase(
        credential: event.credential,
      );
      if (!isClosed) {
        result.fold(
          (failure) => emit(UpdateCredentialError(failure: failure)),
          (_) => emit(UpdateCredentialDone()),
        );
      }
    });
  }
}
