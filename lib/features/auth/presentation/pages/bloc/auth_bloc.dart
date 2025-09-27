import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:datingapp/features/auth/domain/entities/app_user.dart';
import 'package:datingapp/features/auth/domain/repository/auth_repository.dart';

import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepository;
  AppUser? _currentUser;

  AuthBloc({required this.authRepository}) : super(AurhInitial()) {
    on<RegisterButtonClickedEvent>(registerButtonClickedEvent);
    on<LoginButtonClickedEvent>(loginButtonClickedEvent);
    on<LogOutButtonClickedEvent>(logOutButtonClickedEvent);
    on<AuthCheck>(authCheck);
  }

  // check if user already authenticated
  Future<void> authCheck(AuthCheck event, emit) async {
    final AppUser? user = await authRepository.getCurrentUser();

    if (user != null) {
      _currentUser = user;
      emit(Authenticated(user));
    } else {
      emit(Unauthenticated());
    }
  }

  // get current user
  AppUser? get currentUser => _currentUser;

  // register with email + paswword + name
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

  // login with email + password
  Future<void> loginButtonClickedEvent(
    LoginButtonClickedEvent event,
    emit,
  ) async {
    try {
      emit(AuthLoading());

      final user = await authRepository.loginWithEmailAndPassword(
        event.email,
        event.password,
      );

      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        Unauthenticated();
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  // log out
  Future<void> logOutButtonClickedEvent(
    LogOutButtonClickedEvent event,
    emit,
  ) async {
    authRepository.logout();
    emit(Unauthenticated());
  }
}
