import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceServices {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static void saveString(String userName) {
    _prefs.setString('Data', userName);
  }

  static String? getString() {
    return _prefs.getString('Data');
  }
}
