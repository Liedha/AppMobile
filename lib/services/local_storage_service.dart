import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._internal();
  factory LocalStorageService() => _instance;
  LocalStorageService._internal();

  // Save user to local storage
  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_${user.email}', jsonEncode(user.toJson()));
  }

  // Get user from local storage
  Future<User?> getUser(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user_$email');
    if (userData != null) {
      return User.fromJson(jsonDecode(userData));
    }
    return null;
  }

  // Remove user from local storage
  Future<void> removeUser(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_$email');
  }
}
