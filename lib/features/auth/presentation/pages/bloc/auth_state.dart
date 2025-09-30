/* Auth State */

part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

// initial
final class AuthInitial extends AuthState {}

// loading
class AuthLoading extends AuthState {}

// Authenticated
class Authenticated extends AuthState {
  final AppUser user;
  Authenticated(this.user);
}

// Unauthenticated
class Unauthenticated extends AuthState {}

// navigate to signup
class NavigateToSignUp extends AuthState {}

// navigate to signin
class NavigateToSignIn extends AuthState {}

// navigate to signup
class NavigateToSignUpText extends AuthState {}

// navigate to signin
class NavigateToSignInText extends AuthState {}

//navigate to back button
class BackButtonClickedState extends AuthState {}

// Error..
class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

// Splash loading state
class SplashLoading extends AuthState {}
