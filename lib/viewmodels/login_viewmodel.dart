import 'package:flutter/material.dart';
import '../models/user.dart' as Models; // Importing User model with prefix 'Models'
import '../services/database_service.dart'; // Importing DatabaseHelper

class LoginViewModel with ChangeNotifier {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<bool> login(String email, String password) async {
    Models.User? user = await _databaseHelper.getUser(email); // Using DatabaseHelper

    if (user != null && user.password == password) {
      return true;
    }

    return false;
  }

  Future<void> register(String email, String password) async {
    Models.User user = Models.User(email: email, password: password); // Using prefix 'Models'
    await _databaseHelper.insertUser(user);
  }
}
