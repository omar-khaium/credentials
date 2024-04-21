import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/shared/error/failure/failure.dart';
import '../../domain/entities/credential.dart';
import '../../domain/usecases/archive.dart';

part 'archive_credential_event.dart';
part 'archive_credential_state.dart';

class ArchiveCredentialBloc extends Bloc<ArchiveCredentialEvent, ArchiveCredentialState> {
  final ArchiveCredentialUsecase usecase;
  ArchiveCredentialBloc({
    required this.usecase,
  }) : super(ArchiveCredentialInitial()) {
    on<ArchiveCredential>((event, emit) async {
      emit(ArchiveCredentialLoading());
      final result = await usecase(
        credential: event.credential,
      );
      if (!isClosed) {
        result.fold(
          (failure) => emit(ArchiveCredentialError(failure: failure)),
          (_) => emit(ArchiveCredentialDone()),
        );
      }
    });
  }
}
