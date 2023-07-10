part of 'register_user_bloc.dart';

@immutable
abstract class RegisterUserEvent {}

class RegisterUserStart extends RegisterUserEvent {
  final User user;
  RegisterUserStart(this.user);
}
