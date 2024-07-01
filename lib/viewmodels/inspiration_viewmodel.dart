import 'package:flutter/foundation.dart';
import '../models/inspiration.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';

class InspirationViewModel extends ChangeNotifier {
  List<Inspiration> inspirations = [];
  List<Inspiration> filteredInspirations = []; // List untuk menyimpan hasil pencarian
  ApiService _apiService = ApiService();
  LocalStorageService _localStorageService = LocalStorageService();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // Mengambil inspirasi dari API
  Future<void> fetchInspirations() async {
    _setLoading(true);
    inspirations = await _apiService.fetchInspirations();
    filteredInspirations = List.from(inspirations); // Inisialisasi filteredInspirations
    _setLoading(false);
    notifyListeners();
  }

  // Memuat inspirasi dari penyimpanan lokal
  Future<void> loadInspirations() async {
    inspirations = await _localStorageService.getInspirations();
    filteredInspirations = List.from(inspirations); // Inisialisasi filteredInspirations
    notifyListeners();
  }

  // Menyimpan inspirasi ke penyimpanan lokal
  Future<void> saveInspiration(Inspiration inspiration) async {
    await _localStorageService.insertInspiration(inspiration);
  }

  // Fungsi untuk memfilter inspirasi berdasarkan pencarian
  void searchInspirations(String query) {
    if (query.isEmpty) {
      filteredInspirations = List.from(inspirations);
    } else {
      filteredInspirations = inspirations
          .where((inspiration) =>
          inspiration.text.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners(); // Memanggil notifyListeners agar widget yang terkait dengan ViewModel ini diperbarui
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
