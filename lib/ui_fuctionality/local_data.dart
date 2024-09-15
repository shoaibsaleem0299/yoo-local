import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  static Future<void> addString(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? value = prefs.getString(key);
    return value;
  }

  static Future<void> addApiData(
      String key, List<Map<String, dynamic>> value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(value);
    await prefs.setString(key, jsonString);
  }

  static Future<List<Map<String, dynamic>>> getAPiData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(key);
    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      List<Map<String, dynamic>> apiData =
          jsonList.cast<Map<String, dynamic>>();
      return apiData;
    } else {
      return [];
    }
  }
}
