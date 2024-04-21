import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/shared/error/failure/failure.dart';
import '../../domain/usecases/sign_up_with_email_and_password.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final RegistrationUsecase usecase;
  RegistrationBloc({
    required this.usecase,
  }) : super(RegistrationInitial()) {
    on<Register>((event, emit) async {
      emit(RegistrationLoading());
      final result = await usecase(
        email: event.email,
        password: event.password,
      );
      result.fold(
        (failure) => emit(RegistrationError(failure: failure)),
        (user) => emit(RegistrationDone(user: user)),
      );
    });
  }
}
