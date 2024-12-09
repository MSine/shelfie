import 'package:shelfie_app/models/review_model.dart';

class User {
  final int id;
  final String name;
  final String imageUrl;
  final String description;
  final String genre;
  final List<ReviewUser>? reviews;

  User({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.genre,
    this.reviews
  });

  // Factory constructor to parse JSON data
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      imageUrl: json['pp'],
      description: json['bio'],
      genre: json['mostReadGenre'],
      reviews: (json['reviews'] as List)
          .map((reviewJson) => ReviewUser.fromJson(reviewJson))
          .toList(),
    );
  }
}
