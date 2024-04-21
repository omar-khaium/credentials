import 'package:equatable/equatable.dart';
import 'package:credentials/core/shared/error/failure/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/sign_in_with_email_and_password.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationUsecase usecase;
  AuthenticationBloc({
    required this.usecase,
  }) : super(AuthenticationInitial()) {
    on<Authenticate>((event, emit) async {
      emit(AuthenticationLoading());
      final result = await usecase(
        email: event.email,
        password: event.password,
      );
      result.fold(
        (failure) => emit(AuthenticationError(failure: failure)),
        (user) => emit(AuthenticationDone(user: user)),
      );
    });
  }
}
