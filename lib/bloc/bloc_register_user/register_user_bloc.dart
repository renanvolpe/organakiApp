import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:organaki_app/models/user.dart';
import 'package:organaki_app/services/authentication_services.dart';

part 'register_user_event.dart';
part 'register_user_state.dart';

class RegisterUserBloc extends Bloc<RegisterUserEvent, RegisterUserState> {
  RegisterUserBloc(AuthenticationRepository authenticationRepository)
      : super(RegisterUserInitial()) {
    on<RegisterUserStart>((event, emit) async {
      emit(RegisterUserProgress());
      authenticationRepository = AuthenticationRepository();
      var response = await authenticationRepository.registerUser(event.user);
      response.fold((success) => emit(RegisterUserSuccess(success)),
          (failure) => emit(RegisterUserFailure(failure)));
    });
  }
}
