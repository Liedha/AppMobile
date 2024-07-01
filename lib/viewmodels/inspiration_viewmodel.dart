import 'package:flutter/foundation.dart';
import '../services/database_service.dart';
import '../models/inspiration.dart';
import '../models/user.dart';
import '../services/api_service.dart';
import '../services/database_service.dart';
import '../services/local_storage_service.dart';

class InspirationViewModel extends ChangeNotifier {
  List<Inspiration> inspirations = [];
  List<Inspiration> filteredInspirations = [];
  ApiService _apiService = ApiService();
  DatabaseHelper _databaseHelper = DatabaseHelper();
  LocalStorageService _localStorageService = LocalStorageService();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // Fetch inspirations from API
  Future<void> fetchInspirations() async {
    _setLoading(true);
    try {
      inspirations = await _apiService.fetchInspirations();
      filteredInspirations = List.from(inspirations);
    } catch (e) {
      // Handle error here
      print('Error fetching inspirations: $e');
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  // Load inspirations from local storage (SQLite)
  Future<void> loadInspirations() async {
    inspirations = await _databaseHelper.getInspirations();
    filteredInspirations = List.from(inspirations);
    notifyListeners();
  }

  // Save inspiration to local storage (SQLite)
  Future<void> saveInspiration(Inspiration inspiration) async {
    await _databaseHelper.insertInspiration(inspiration);
    inspirations = await _databaseHelper.getInspirations(); // Refresh inspirations after saving
    filteredInspirations = List.from(inspirations);
    notifyListeners();
  }

  // Function to filter inspirations based on search query
  void searchInspirations(String query) {
    if (query.isEmpty) {
      filteredInspirations = List.from(inspirations);
    } else {
      filteredInspirations = inspirations
          .where((inspiration) =>
          inspiration.text.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Save user data to SharedPreferences
  Future<void> saveUser(User user) async {
    await _localStorageService.saveUser(user);
  }

  // Get user data from SharedPreferences
  Future<User?> getUser(String email) async {
    return await _localStorageService.getUser(email);
  }

  // Remove user data from SharedPreferences
  Future<void> removeUser(String email) async {
    await _localStorageService.removeUser(email);
  }
}
