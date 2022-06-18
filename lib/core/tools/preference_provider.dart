import 'package:shared_preferences/shared_preferences.dart';

class PreferenceController {
  Future<void> saveUserInfo(PrefUserModel user) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.setString("email", user.email);
    await preferences.setString("password", user.password);
  }

  Future<PrefUserModel> getUserInfo() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return PrefUserModel(
        email: preferences.getString("email") ?? "",
        password: preferences.getString("password") ?? "");
  }

  Future<bool?> checkLoginStatus() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.getBool("token");
  }

  Future<void> saveToken(bool token) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool("token", token);
  }

  // void removeToken(bool token) async {
  //   final SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setBool("token", token);
  // }
}

class PrefUserModel {
  String email;
  String password;
  PrefUserModel({
    required this.email,
    required this.password,
  });
}
