import 'package:flutter/material.dart';
import 'group_chat_screen.dart';

class MessagesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Sample data for groups and DMs
    final List<Map<String, dynamic>> groupChats = [
      {'name': 'Book Lovers', 'lastMessage': 'Did you read the latest release?'},
      {'name': 'Sci-Fi Fans', 'lastMessage': 'The new movie was amazing!'}
    ];
    final List<Map<String, dynamic>> dms = [
      {'name': 'Alice', 'lastMessage': 'Hey! What are you reading?'},
      {'name': 'Bob', 'lastMessage': 'Can you recommend a thriller?'}
    ];

    return Scaffold(
      appBar: AppBar(title: Text("Messages")),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Group Chats", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          ...groupChats.map((chat) => ListTile(
            title: Text(chat['name']),
            subtitle: Text(chat['lastMessage']),
            leading: CircleAvatar(child: Icon(Icons.group)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => GroupChatScreen(groupName: chat['name'])),
              );
            },
          )),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Direct Messages", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          ...dms.map((chat) => ListTile(
            title: Text(chat['name']),
            subtitle: Text(chat['lastMessage']),
            leading: CircleAvatar(child: Icon(Icons.person)),
            onTap: () {
              //Navigator.pushNamed(context, '/chat', arguments: {'name': chat['name']});
            },
          )),
        ],
      ),
    );
  }
}
