import 'dart:convert';
import 'package:http/http.dart' as http;

class ReviewUser {
  final String title;
  final String author;
  final String text;
  final double rating;

  ReviewUser({
    required this.title,
    required this.author,
    required this.text,
    required this.rating,
  });

  // Factory constructor to parse JSON data
  factory ReviewUser.fromJson(Map<String, dynamic> json) {
    return ReviewUser(
      title: json['bookTitle'],
      author: json['bookAuthor'] ?? "Unknown",
      text: json['text'],
      rating: json['rating'].toDouble() / 2,
    );
  }
}

class ReviewBook {
  final String username;
  final double rating;
  final String text;

  ReviewBook({
    required this.username,
    required this.rating,
    required this.text,
  });

  // Factory constructor to parse JSON data
  factory ReviewBook.fromJson(Map<String, dynamic> json) {
    return ReviewBook(
      username: json['name'],
      rating: json['rating'].toDouble() / 2,
      text: json['text'],
    );
  }

  static void postReview(int bookId, int userId, double rating, String text) async {
    final Map<String, dynamic> jsonMap = {
      'bookId': bookId,
      'userId': userId,
      'rating': rating.toInt() * 2,
      'text': text,
    };
    http.post(
        Uri.parse('http://10.0.2.2:8080/api/book/review'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(jsonMap)
    );
  }
}
