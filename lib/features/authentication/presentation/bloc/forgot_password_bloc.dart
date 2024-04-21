import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/shared/error/failure/failure.dart';
import '../../domain/usecases/forgot_password.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ForgotPasswordUsecase usecase;
  ForgotPasswordBloc({
    required this.usecase,
  }) : super(ForgotPasswordInitial()) {
    on<ForgotPassword>((event, emit) async {
      emit(ForgotPasswordLoading());
      final result = await usecase(
        email: event.email,
      );
      result.fold(
        (failure) => emit(ForgotPasswordError(failure: failure)),
        (_) => emit(ForgotPasswordDone()),
      );
    });
  }
}
