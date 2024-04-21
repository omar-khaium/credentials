import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/shared/error/failure/failure.dart';
import '../../domain/entities/credential.dart';
import '../../domain/usecases/add.dart';

part 'create_credential_event.dart';
part 'create_credential_state.dart';

class CreateCredentialBloc extends Bloc<CreateCredentialEvent, CreateCredentialState> {
  final CreateCredentialUsecase usecase;
  CreateCredentialBloc({
    required this.usecase,
  }) : super(CreateCredentialInitial()) {
    on<CreateCredential>((event, emit) async {
      emit(CreateCredentialLoading());
      final result = await usecase(
        credential: event.credential,
      );
      if (!isClosed) {
        result.fold(
          (failure) => emit(CreateCredentialError(failure: failure)),
          (_) => emit(CreateCredentialDone()),
        );
      }
    });
  }
}
