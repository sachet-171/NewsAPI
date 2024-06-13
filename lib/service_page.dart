import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  static const String _apiKey = 'dd5194a6c2c7436e9727f0bb98094686';
  static const String _baseUrl = 'https://newsapi.org/v2/top-headlines';

  Future<List<dynamic>> fetchNews(String country) async {
    final url = '$_baseUrl?country=$country&apiKey=$_apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse['articles'];
    } else {
      print('Failed to load news data');
      return [];
    }
  }
}
