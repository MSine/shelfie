import 'dart:convert';
import 'package:http/http.dart' as http;

class Message {
  final int senderId;
  final String content;
  final DateTime timestamp;

  Message({
    required this.senderId,
    required this.content,
    required this.timestamp
  });
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
      lastMessageSender: json['lastMessageSender'],
      lastMessage: json['lastMessage'],
      time: json['time'],
      isGroup: json['type'] == "group",
    );
  }

  // Fetch a user from the db
  static Future<List<MessageOverview>> fetchMessageOverviews(int userId) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8080/api/messages/overview/$userId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<MessageOverview>.from(data.map((json) => MessageOverview.fromJson(json)));
    } else {
      throw Exception('Failed to load message overviews');
    }
  }
}