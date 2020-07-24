import 'package:shared_preferences/shared_preferences.dart';

class CacheStore {
  static Future<void> setBreeds(String breeds) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String oldBreeds = prefs.getString('breeds') ?? "";
    if (oldBreeds != breeds) {
      prefs.setString('breeds', breeds);
    }
  }

  static Future<String> getBreeds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('breeds') ?? "[{}]";
  }
}
