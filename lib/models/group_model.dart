import 'package:shelfie_app/models/user_model.dart';

class Group {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final String activityLevel;
  final List<User> members;

  Group({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.activityLevel,
    required this.members,
  });
  //Factory constructor to parse JSON data
  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image'],
      description: json['description'],
      activityLevel: json['activity level'],
      members: (json['reviews'] as List)
          .map((reviewJson) => User.fromJson(reviewJson))
          .toList(),
    );
  }
}
