part of 'login_auth_bloc.dart';

@immutable
abstract class LoginAuthEvent {}

class LoginAuthStart extends LoginAuthEvent {
  final String username;
  final String password;
  LoginAuthStart(this.username, this.password);
}
