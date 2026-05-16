import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static late SharedPreferences _prefs;
  
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  
  static Future<void> saveToken(String token) async {
    await _prefs.setString('auth_token', token);
  }
  
  static String? getToken() {
    return _prefs.getString('auth_token');
  }
  
  static Future<void> saveUser(Map<String, dynamic> user) async {
    await _prefs.setString('user_data', json.encode(user));
  }
  
  static Map<String, dynamic>? getUser() {
    final String? userString = _prefs.getString('user_data');
    if (userString != null) {
      return json.decode(userString);
    }
    return null;
  }
  
  static bool isLoggedIn() {
    return getToken() != null;
  }
  
  static Future<void> clearAll() async {
    await _prefs.clear();
  }
}