part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthInitialEvent extends AuthEvent {}

class RegisterButtonClickedEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  RegisterButtonClickedEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}

class LoginButtonClickedEvent extends AuthEvent {
  final String email;
  final String password;

  LoginButtonClickedEvent({required this.email, required this.password});
}

class LogOutButtonClickedEvent extends AuthEvent {}

class SignUpButtonClickedEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  SignUpButtonClickedEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}

class SignInButtonClickedEvent extends AuthEvent {}

class SignUpTextClickedEvent extends AuthEvent {}

class SignInTextClickedEvent extends AuthEvent {}

class AuthCheck extends AuthEvent {}

class SplashInitialized extends AuthEvent {}
