/* Auth State */

part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

// initial
final class AurhInitial extends AuthState {}

// loading
class AuthLoading extends AuthState {}

// Authenticated
class Authenticated extends AuthState {
  final AppUser user;
  Authenticated(this.user);
}

// Unauthenticated
class Unauthenticated extends AuthState {}

// Error..
class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
