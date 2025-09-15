part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

class RegisterInitialEvent extends RegisterEvent {}

class RegisterButtonClickedEvent extends RegisterEvent {
  final String name;
  final String email;
  final String password;

  RegisterButtonClickedEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}
