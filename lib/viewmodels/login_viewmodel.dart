import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class LoginViewModel with ChangeNotifier {
  Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user_$email');

    if (userData != null) {
      final user = User.fromJson(Map<String, dynamic>.from(jsonDecode(userData)));
      if (user.password == password) {
        return true;
      }
    }
    return false;
  }

  Future<void> register(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final user = User(email: email, password: password);
    await prefs.setString('user_$email', jsonEncode(user.toJson()));
  }
}
