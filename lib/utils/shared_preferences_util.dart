import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static Future<void> saveScreenState(String screen) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('last_screen', screen);
    } catch (e) {
      print('Error saving screen state: $e');
    }
  }

  static Future<String> loadScreenState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('last_screen') ?? 'home';
    } catch (e) {
      print('Error loading screen state: $e');
      return 'home';
    }
  }

  static Future<void> saveCity(String city) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('last_city', city);
    } catch (e) {
      print('Error saving city: $e');
    }
  }

  static Future<String?> loadCity() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('last_city');
    } catch (e) {
      print('Error loading city: $e');
      return null;
    }
  }

  static Future<void> clearScreenState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('last_screen');
      await prefs.remove('last_city');
    } catch (e) {
      print('Error clearing screen state: $e');
    }
  }
}