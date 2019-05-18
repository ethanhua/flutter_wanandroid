import 'package:shared_preferences/shared_preferences.dart';

class SpUtils{

  static put(String key, String value) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static get(String key, Function callback) async {
    SharedPreferences.getInstance().then((prefs) {
      callback(prefs?.getString(key));
    });
  }

}