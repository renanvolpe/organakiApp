import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:organaki_app/models/user.dart';
import 'package:organaki_app/services/authentication_services.dart';

part 'login_auth_event.dart';
part 'login_auth_state.dart';

class LoginAuthBloc extends Bloc<LoginAuthEvent, LoginAuthState> {
  LoginAuthBloc(AuthenticationRepository authenticationRepository)
      : super(LoginAuthInitial()) {
    on<LoginAuthStart>((event, emit) async {
      emit(LoginAuthProgress());
      authenticationRepository = AuthenticationRepository();
      var response =
          await authenticationRepository.doLoginUser(event.username, event.password);
      response.fold((success) => emit(LoginAuthSuccess(success)),
          (error) => emit(LoginAuthFailure()));
    });
  }
}
