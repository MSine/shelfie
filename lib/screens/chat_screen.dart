import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<types.Message> messages = []; // Dynamically load messages

    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
      ),
      body: Chat(
        messages: messages,
        onSendPressed: (types.PartialText message) {
          // Handle message send
        },
        user: types.User(id: 'userId'), // Current user ID
      ),
    );
  }
}
