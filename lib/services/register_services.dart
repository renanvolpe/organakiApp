import 'package:dio/dio.dart';
import 'package:organaki_app/core/endpoints.dart';
import 'package:organaki_app/models/user.dart';
import 'package:result_dart/result_dart.dart';

abstract class AuthenticationService {
  Future<Result<User, String>> doLoginUser(String username, String password);
  Future<Result<User, String>> registerUser(Map<String, dynamic> body);
  setupServiceUser();
}

class AuthenticationRepository implements AuthenticationService {
  final dio = Dio();
  String? errorMessage;

  @override
  Future<Result<User, String>> doLoginUser(
      String username, String password) async {
    var response = await dio.get(
      Endpoints.baseUrlMock + Endpoints.loginMock,
    );
    try {
      if (response.statusCode == 200) {
        User user = User.fromMap(response.data);
        return Success(user);
      } else if (response.statusCode == 400) {
        errorMessage = "Chamada feita de maneira errada";
      } else if (response.statusCode == 500) {
        errorMessage = "Sistema fora do ar, contate o administrador";
      }
    } catch (e) {
      print("Error AuthenticationRepository ::  doLoginUser :: $e ");
      errorMessage = "Erro do sistema";
    }
    return Failure(errorMessage ?? "Erro não esperado");
  }

  @override
  Future<Result<User, String>> registerUser(Map<String, dynamic> body) async {
    try {
      var response = await dio.post(
        Endpoints.baseUrlMock + Endpoints.registerMock,
        data: body,
      );
      if (response.statusCode == 201) {
        User user = User.fromMap(response.data);
        return Success(user);
      } else if (response.statusCode == 400) {
        errorMessage = "Chamada feita de maneira errada";
      } else if (response.statusCode == 500) {
        errorMessage = "Sistema fora do ar, contate o administrador";
      }
    } catch (e) {
      print("Error AuthenticationRepository :: registerUser :: $e");
      errorMessage = "Erro do sistema";
    }
    return Failure(errorMessage ?? "Erro não esperado");
  }

  @override
  setupServiceUser() {
    throw UnimplementedError();
  }
}
