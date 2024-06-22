import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

const String tokenKey = 'token';
const String nameKey = 'name';
const String emailKey = 'email';
const String addressKey = 'address';
const String cityKey = 'city';
const String userIdKey = 'userId';
const String userTypeKey = 'userType';

Future<void> setToken({required String? token}) async {
  try {
    // Get the instance of SharedPreferences
    final prefs = await SharedPreferences.getInstance();

    // Store the token in SharedPreferences
    await prefs.setString(tokenKey, token!);

    if (kDebugMode) {
      print('Token set successfully.');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error setting token: $e');
    }
  }
}

Future<void> setString({required String key, required String data}) async {
  try {
    // Get the instance of SharedPreferences
    final prefs = await SharedPreferences.getInstance();

    // Store the name in SharedPreferences
    await prefs.setString(key, data);

    if (kDebugMode) {
      print('Name set successfully.');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error setting name: $e');
    }
  }
}

Future<String?> getString({required String key}) async {
  try {
    // Get the instance of SharedPreferences
    final prefs = await SharedPreferences.getInstance();

    // Fetch the stored token
    final storedKey = prefs.getString(key);

    if (kDebugMode) {
      print('Retrieved key: $storedKey');
    }

    return storedKey;
  } catch (e) {
    if (kDebugMode) {
      print('Error getting token: $e');
    }

    return null;
  }
}

Future<void> removeToken() async {
  try {
    // Get the instance of SharedPreferences
    final prefs = await SharedPreferences.getInstance();

    // Remove the token from SharedPreferences
    await prefs.remove(tokenKey);

    if (kDebugMode) {
      print('Token removed successfully.');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error removing token: $e');
    }
  }
}

Future<String?> getToken() async {
  try {
    // Get the instance of SharedPreferences
    final prefs = await SharedPreferences.getInstance();

    // Fetch the stored token
    final storedToken = prefs.getString(tokenKey);

    if (kDebugMode) {
      print('Retrieved Token: $storedToken');
    }

    return storedToken;
  } catch (e) {
    if (kDebugMode) {
      print('Error getting token: $e');
    }

    return null;
  }
}
