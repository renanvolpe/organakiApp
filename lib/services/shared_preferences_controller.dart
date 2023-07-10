import 'package:organaki_app/models/user.dart';
import 'package:result_dart/result_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesAuthController {
  void saveLoginSharedPreferences(User user) async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    prefs.setString("id", user.id!); // TODO update this when recieve
    prefs.setString("email", user.email);
    prefs.setString("name", user.name);
     prefs.setString("token", user.token!);
  }

  static void logoutSharedPreferences() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    prefs.remove("id");
    prefs.remove("email");
    prefs.remove("name");
    prefs.remove("token");
  }

  Future<Result<User, String>> readSharedPreferencesLogin() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    String? errorMessage;
    try {
      User user = User(
          prefs.getString("token")!,
          prefs.getString("id"),
          prefs.getString("name")!,
          prefs.getString("email")!,
          ""
          );
      return Success(user);
    } catch (e) {
      logoutSharedPreferences();
      errorMessage = e.toString();
    }
    print("Erro login Shared Preferences: $errorMessage");
    return const Failure("login não realizado");
  }
}
