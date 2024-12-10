import 'package:shelfie_app/models/review_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Book {
  final int id;
  final String title;
  final String author;
  final String imageUrl;
  final double rating;
  final List<ReviewBook>? reviews;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.rating,
    this.reviews,
  });

  // Factory constructor to parse JSON data
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['name'],
      author: json['author'] ?? 'Unknown',
      imageUrl: json['cover_img'] ?? '',
      rating: json.containsKey('rating') ? json['rating'].toDouble() : 0,
      reviews: json.containsKey('reviews') ? (json['reviews'] as List)
          .map((reviewJson) => ReviewBook.fromJson(reviewJson))
          .toList()
          : null,
    );
  }

  // Fetch books from the db
  static Future<List<Book>> fetchBookSearch(String str) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8080/api/book/search/$str'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Book>.from(data.map((i) => Book.fromJson(i)));
    } else {
      throw Exception('Failed to load books');
    }
  }

  static Future<Book> fetchBook(int bookId) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8080/api/book/$bookId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Book.fromJson(data);
    } else {
      throw Exception('Failed to load book details');
    }
  }
}