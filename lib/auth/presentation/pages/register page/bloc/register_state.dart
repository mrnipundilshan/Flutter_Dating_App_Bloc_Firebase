part of 'register_bloc.dart';

@immutable
sealed class RegisterState {}

// initial
final class RegisterInitial extends RegisterState {}

// loading
class RegisterLoading extends RegisterState {}

// register success
class RegisterSuccess extends RegisterState {}

// register failed
class RegisterFailed extends RegisterState {}

// error
class RegisterError extends RegisterState {
  final String message;
  RegisterError(this.message);
}
