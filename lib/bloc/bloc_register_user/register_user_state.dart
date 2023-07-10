part of 'register_user_bloc.dart';

@immutable
abstract class RegisterUserState {}

class RegisterUserInitial extends RegisterUserState {}

class RegisterUserProgress extends RegisterUserState {}

class RegisterUserSuccess extends RegisterUserState {
  final String successMessage;
  RegisterUserSuccess(this.successMessage);
}

class RegisterUserFailure extends RegisterUserState {
  final String errorMessage;
  RegisterUserFailure(this.errorMessage);
}
