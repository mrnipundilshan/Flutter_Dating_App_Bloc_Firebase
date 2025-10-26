import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:datingapp/features/auth/domain/entities/app_user.dart';
import 'package:datingapp/features/auth/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepository;
  AppUser? _currentUser;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<SignUpButtonClickedEvent>(signUpButtonClickedEvent);
    on<LoginButtonClickedEvent>(loginButtonClickedEvent);
    on<LogOutButtonClickedEvent>(logOutButtonClickedEvent);
    on<AuthCheck>(authCheck);
    on<SplashInitialized>(splashInitialized);

    on<SignInButtonClickedEvent>(signInButtonClickedEvent);

    on<SignUpTextClickedEvent>(signUpTextClickedEvent);

    on<SignInTextClickedEvent>(signInTextClickedEvent);
  }

  // check if user already authenticated
  Future<void> authCheck(AuthCheck event, emit) async {
    emit(AuthLoading());
    final AppUser? user = await authRepository.getCurrentUser();

    if (user != null) {
      _currentUser = user;
      emit(Authenticated(user));
    } else {
      emit(Unauthenticated());
    }
  }

  // handle splash screen initialization with timing
  Future<void> splashInitialized(SplashInitialized event, emit) async {
    emit(SplashLoading());

    // Wait minimum 2 seconds
    await Future.delayed(const Duration(seconds: 2));

    // Then check authentication
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

  // sign up with email + paswword + name
  FutureOr<void> signUpButtonClickedEvent(
    SignUpButtonClickedEvent event,
    Emitter<AuthState> emit,
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
    } on FirebaseAuthException catch (e) {
      String message;

      switch (e.code) {
        case 'email-already-in-use':
          message = 'Email already in use';
          break;
        case 'invalid-email':
          message = 'Invalid email address';
          break;
        case 'weak-password':
          message = 'Password too weak';
          break;
        case 'user-not-found':
          message = 'No account found';
          break;
        case 'wrong-password':
          message = 'Incorrect password';
          break;
        case 'user-disabled':
          message = 'Account disabled';
          break;
        case 'too-many-requests':
          message = 'Too many attempts. Try later';
          break;
        case 'operation-not-allowed':
          message = 'Sign up not allowed';
          break;
        default:
          message = 'Sign up failed. Try again';
      }

      emit(AuthError(message));
    } catch (e) {
      emit(AuthError('Sign up failed. Try again'));
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
        emit(Unauthenticated());
      }
    } on FirebaseAuthException catch (e) {
      String message;

      switch (e.code) {
        case 'user-not-found':
          message = 'No account found';
          break;
        case 'wrong-password':
          message = 'Incorrect password';
          break;
        case 'invalid-email':
          message = 'Invalid email address';
          break;
        case 'user-disabled':
          message = 'Account disabled';
          break;
        case 'too-many-requests':
          message = 'Too many attempts. Try later';
          break;
        case 'invalid-credential':
          message = 'Invalid credentials';
          break;
        default:
          message = 'Login failed. Try again';
      }

      emit(AuthError(message));
    } catch (e) {
      emit(AuthError('Login failed. Try again'));
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

  void signInButtonClickedEvent(SignInButtonClickedEvent event, emit) {
    emit(NavigateToSignIn());
  }

  void signUpTextClickedEvent(SignUpTextClickedEvent event, emit) {
    emit(NavigateToSignUpText());
  }

  void signInTextClickedEvent(SignInTextClickedEvent event, emit) {
    emit(NavigateToSignInText());
  }
}
