import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/inspiration.dart';

class ApiService {
  final String apiUrl = 'https://type.fit/api/quotes';

  Future<List<Inspiration>> fetchInspirations() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Inspiration.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load inspirations');
    }
  }
}
