import 'package:shelfie_app/main.dart';
import 'package:shelfie_app/models/user_model.dart';
import 'package:shelfie_app/models/group_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NotificationModel implements Promotable {
  final User user;
  final Group? group;

  NotificationModel({
    required this.user,
    this.group,
  });

  //Factory constructor to parse JSON data
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      user: User.fromJson(json['user']),
      group: json['group'] != null ? Group.fromJson(json['group']) : null,
    );
  }

  // Fetch a user from the db
  static Future<List<NotificationModel>> fetchNotifications() async {
    final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/api/match/all/${MyApp.userId}'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<NotificationModel>.from(data.map((json) => NotificationModel.fromJson(json)));
    } else {
      throw Exception('Failed to load group');
    }
  }
}