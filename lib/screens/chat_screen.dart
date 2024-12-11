import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:shelfie_app/main.dart';
import '../models/user_model.dart';
import '../models/message_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  final bool isGroup;
  final int otherId;
  final String name;

  const ChatScreen({
    Key? key,
    required this.isGroup,
    required this.otherId,
    required this.name,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<types.Message> _messages = [];
  late types.User _currentUser; // Replace with the actual user ID
  late types.User _otherUser; // Replace with the actual user ID

  @override
  void initState() {
    super.initState();
    _currentUser = types.User(id: MyApp.userId.toString());
    _otherUser = types.User(id: "G${widget.otherId}");
    initMessages();
  }

  void initMessages() async {
    try {
      final (Promotable other, List<MessageModel> messageList) =
      await MessageModel.fetchMessages(widget.otherId, widget.isGroup);

      final newMessages = messageList.map((message) {
        final isCurrentUser = message.sender == 1;
        final displayText = widget.isGroup && message.sender == 0
            ? '${message.senderName}:\n${message.text}'
            : message.text;
        return types.TextMessage(
          author: isCurrentUser ? _currentUser : _otherUser,
          createdAt: DateTime.parse(message.time).millisecondsSinceEpoch,
          id: DateTime.now().toString(),
          text: displayText,
        );
      }).toList();

      setState(() {
        _messages.insertAll(0, newMessages);
      });
    } catch (error) {
      print("Error initializing messages: $error");
    }
  }

  void _handleSendPressed(types.PartialText message) {
    final newMessage = types.TextMessage(
      author: _currentUser,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: DateTime.now().toString(),
      text: message.text,
    );

    _sendMessage(message.text);

    setState(() {
      _messages.insert(0, newMessage);
    });
  }

  void _sendMessage(String text) {
    final String userGroupText = widget.isGroup ? "group" : "user";
    final Map<String, dynamic> jsonMap = {
      'text': text,
      'sender': MyApp.userId,
      'recv': widget.otherId,
    };
    http.post(
        Uri.parse('http://10.0.2.2:8080/api/messages/${userGroupText}/send'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(jsonMap)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => {
            if (widget.isGroup) {
              Navigator.pushNamed(context, '/groupProfile',
                arguments: {
                  'groupId' : widget.otherId,
                }
              ),
            }
            else {
              Navigator.pushNamed(context, '/userProfile',
                  arguments: {
                    'userId': widget.otherId,
                  }
              ),
            }
          },
          child: Text(widget.name,),
        ),
      ),
      body: Chat(
        messages: _messages,
        onSendPressed: _handleSendPressed,
        user: _currentUser,
      ),
    );
  }
}