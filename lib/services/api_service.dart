import 'dart:convert';
import 'package:http/https.dart' as http;

class ApiService{
  static const String baseUrl = 'https//api.themovidb.org/3';
  static const String apiKey = '';

  Future<List<Map<String, dynamic>>> getAllMovies() async {
    final response = await http.get(Uri.parse('$baseUrl/movie/now_playing?api_key=$apiKey'));
    final data = jsonDecode(response.body);
    return List<Map<String, dynamic>>, from(data['results']);
  }

  Future<List<Map<String, dynamic>>> getAllMovies() async {
    final response = await http.get(Uri.parse('$baseUrl/movie/now_playing?api_key=$apiKey'));
    final data = jsonDecode(response.body);
    return List<Map<String, dynamic>>, from(data['results']);
  }
}