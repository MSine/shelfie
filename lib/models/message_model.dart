import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shelfie_app/main.dart';
import '../models/user_model.dart';
import '../models/group_model.dart';

class MessageModel {
  final int sender;
  final String? senderName;
  final String text;
  final String time;

  MessageModel({
    required this.sender,
    this.senderName,
    required this.text,
    required this.time,
  });

  // Factory constructor to parse JSON data
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      sender: json['sender'],
      senderName: json['senderName'],
      text: json['text'],
      time: json['time'],
    );
  }

  // Fetch from the db
  static Future<(Promotable, List<MessageModel>)> fetchMessages(int otherId, bool isGroup) async {
    final String userGroupText = isGroup ? 'group' : 'user';
    final response = await http.get(
        Uri.parse('${MyApp.serverIp}/api/messages/$userGroupText/${MyApp.userId}/$otherId')
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data.containsKey('partner')) {
        return (
          User.fromJson(data['partner']),
          List<MessageModel>.from((data['messages'] as List)
              .map((mess) => MessageModel.fromJson(mess)))
        );
      }
      return (
        Group.fromJson(data['group']),
        List<MessageModel>.from((data['messages'] as List)
            .map((mess) => MessageModel.fromJson(mess)))
      );
    } else {
      throw Exception('Failed to load message overviews');
    }
  }
}

class MessageOverview {
  final int id;
  final String name;
  final String imageUrl;
  final String lastMessageSender;
  final String lastMessage;
  final String time;
  final bool isGroup;

  MessageOverview({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.lastMessageSender,
    required this.lastMessage,
    required this.time,
    required this.isGroup,
  });

  // Factory constructor to parse JSON data
  factory MessageOverview.fromJson(Map<String, dynamic> json) {
    return MessageOverview(
      id: json['id'],
      name: json['name'],
      imageUrl: json['pp'],
      lastMessageSender: json['lastMessageSender'] ?? '',
      lastMessage: json['lastMessage'] ?? '',
      time: json['time'] ?? '',
      isGroup: json['type'] == "group",
    );
  }

  // Fetch overviews from the db
  static Future<List<MessageOverview>> fetchMessageOverviews() async {
    final response = await http.get(Uri.parse('${MyApp.serverIp}/api/messages/overview/${MyApp.userId}'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<MessageOverview>.from(data.map((json) => MessageOverview.fromJson(json)));
    } else {
      throw Exception('Failed to load message overviews');
    }
  }
}