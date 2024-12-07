import 'package:shelfie_app/models/review_model.dart';

class Book {
  final String title;
  final String author;
  final String imageUrl;
  final double rating;
  final List<ReviewBook>? reviews;

  Book({
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.rating,
    this.reviews,
  });

  // Factory constructor to parse JSON data
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'],
      author: json['author'],
      imageUrl: json['cover_img'],
      rating: json['rating'].toDouble(),
      reviews: (json['reviews'] as List)
          .map((reviewJson) => ReviewBook.fromJson(reviewJson))
          .toList(),
    );
  }
}