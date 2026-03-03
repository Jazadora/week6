import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class ApiService {
  // Base URL for the API - Using JSONPlaceholder for demo (no API key needed)
  final String baseUrl = 'jsonplaceholder.typicode.com';

  // Method to fetch news articles
  // Note: JSONPlaceholder returns posts, which we'll adapt to our Article model
  Future<List<Article>> fetchNewsArticles() async {
    // 1. Build the URL properly (DO NOT use string concatenation)
    final uri = Uri.https(baseUrl, '/posts');

    try {
      // 2. Make the network request
      final response = await http.get(uri);

      // 3. Check status code
      if (response.statusCode == 200) {
        // 4. Parse JSON response
        final List<dynamic> jsonData = jsonDecode(response.body);

        // 5. Convert each JSON object to Article model
        // Adapting JSONPlaceholder posts to Article format
        return jsonData.take(20).map((json) {
          return Article(
            title: json['title'] ?? 'No title',
            description: json['body'] ?? 'No description',
            imageUrl:
                'https://via.placeholder.com/600/92c952', // Placeholder image
            source: 'JSONPlaceholder',
            publishedAt: DateTime.now().toIso8601String(),
          );
        }).toList();
      } else {
        // 6. Handle HTTP errors
        throw Exception('Failed to load articles: ${response.statusCode}');
      }
    } catch (e) {
      // 7. Handle network errors
      throw Exception('Network error: $e');
    }
  }
}
