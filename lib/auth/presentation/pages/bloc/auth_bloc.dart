import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:datingapp/auth/domain/entities/app_user.dart';
import 'package:datingapp/auth/domain/repository/auth_repository.dart';

import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AurhBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepository;
  AppUser? _currentUser;

  AurhBloc({required this.authRepository}) : super(AurhInitial()) {
    on<RegisterButtonClickedEvent>(registerButtonClickedEvent);
  }

  // register with email + paswword
  Future<void> registerButtonClickedEvent(
    RegisterButtonClickedEvent event,
    emit,
  ) async {
    try {
      emit(AuthLoading());

      final user = await authRepository.registerWithEmailAndPassword(
        event.name,
        event.email,
        event.password,
      );

      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }
}
