import 'dart:convert';
import 'package:http/http.dart' as http;
import '../main.dart';

class Genre {
  final int id;
  final String name;

  Genre({
    required this.id,
    required this.name,
  });

  // Factory constructor to parse JSON data
  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
    );
  }

  // Fetch genres from the db
  static Future<List<Genre>> fetchGenres() async {
    final response = await http.get(Uri.parse('${MyApp.serverIp}/api/genre/all'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Genre>.from(data.map((i) => Genre.fromJson(i)));
    } else {
      throw Exception('Failed to load genres');
    }
  }
}