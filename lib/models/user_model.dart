import 'package:shelfie_app/models/review_model.dart';
import 'group_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class Promotable {
  factory Promotable.fromJson(Map<String, dynamic> json) {
    try {
      // Attempt to create a User
      return User.fromJson(json);
    } catch (_) {
      // If it fails, attempt to create a Group
      try {
        return Group.fromJson(json);
      } catch (_) {
        throw Exception('Unknown JSON structure');
      }
    }
  }
}

class User implements Promotable {
  final int id;
  final String name;
  final String imageUrl;
  final String description;
  final String? genre;
  final List<ReviewUser>? reviews;

  User({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.genre,
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
      reviews: json['reviews'] != null ? (json['reviews'] as List)
          .map((reviewJson) => ReviewUser.fromJson(reviewJson))
          .toList()
          : null,
    );
  }

  // Fetch a user from the db
  static Future<User> fetchUser(int userId) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8080/api/user/$userId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return User.fromJson(data);
    } else {
      throw Exception('Failed to load user');
    }
  }
}
