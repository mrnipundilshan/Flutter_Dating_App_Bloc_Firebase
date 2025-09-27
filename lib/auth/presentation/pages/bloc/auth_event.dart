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
