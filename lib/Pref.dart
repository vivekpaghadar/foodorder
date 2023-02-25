import 'package:shared_preferences/shared_preferences.dart';

class Pref {

  // Obtain shared preferences.
  static SharedPreferences? prefs;

  static const String token = 'token';

  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static saveToken(String accessToken){
    prefs?.setString(token, accessToken);
  }

  static String? getToken(){
    return prefs?.getString(token);
  }

  static removeToken(){
    return prefs?.remove(token);
  }

}