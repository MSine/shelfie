import 'package:shelfie_app/main.dart';
import 'package:shelfie_app/models/user_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Group implements Promotable {
  final int id;
  final int adminId;
  final String name;
  final String imageUrl;
  final String description;
  final List<Future<User>>? members;

  Group({
    required this.id,
    required this.adminId,
    required this.name,
    required this.imageUrl,
    required this.description,
    this.members,
  });
  //Factory constructor to parse JSON data
  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'],
      adminId: json['admin'],
      name: json['name'],
      imageUrl: json['pp'],
      description: json['bio'] ?? "No description",
      members: json.containsKey('members') ? (json['members'] as List)
          .map((reviewJson) async => User.fromJson(reviewJson))
          .toList()
          : null,
    );
  }

  // Fetch a user from the db
  static Future<Group> fetchGroup(int groupId) async {
    final response = await http.get(Uri.parse('${MyApp.serverIp}/api/group/$groupId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Group.fromJson(data);
    } else {
      throw Exception('Failed to load group');
    }
  }

  // Fetch a user from the db
  static void postCreateGroup(String name, String description, String image, List<int> genres) {
    final Map<String, dynamic> jsonMap = {
      'adminId': MyApp.userId,
      'name': name,
      'pp': image,
      'bio': description,
      'genres': genres,
    };
    http.post(
        Uri.parse('${MyApp.serverIp}/api/group/create'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(jsonMap)
    );
  }

  static void postEditGroup(int id, String name, String description, String image) {
    final Map<String, dynamic> jsonMap = {
      'id': id,
      'name': name,
      'bio': description,
      'pp': image,
    };
    http.post(
        Uri.parse('${MyApp.serverIp}/api/group/edit'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(jsonMap)
    );
  }

  static void postMatch(int otherId, int groupId, bool isRejected) {
    final String reject = isRejected ? 'reject/': '';
    http.post(
      Uri.parse('${MyApp.serverIp}/api/match/group/$reject$otherId/$groupId'),
      headers: {'Content-Type': 'application/json'},
    );
  }
}