import 'package:flutter/material.dart';
import '../models/message_model.dart';

class MessagesScreen extends StatefulWidget {
  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  late Future<List<MessageOverview>> _messageOverviewsFuture;

  @override
  void initState() {
    super.initState();
    _messageOverviewsFuture = MessageOverview.fetchMessageOverviews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Messages")
      ),
      floatingActionButton: IconButton(
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/groupCreate');
        },
      ),
      body: FutureBuilder<List<MessageOverview>>(
        future: _messageOverviewsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return Center(child: Text("Book details not available"));
          }

          final messageOverviews = snapshot.data!;
          return ListView.builder(
            itemCount: messageOverviews.length,
            itemBuilder: (context, index) {
              final messageOverview = messageOverviews[index];
              return ListTile(
                title: Text(messageOverview.name),
                subtitle: Text(
                  messageOverview.isGroup
                      ? '${messageOverview.lastMessageSender}: ${messageOverview.lastMessage}'
                      : messageOverview.lastMessage,
                  overflow: TextOverflow.ellipsis,
                ),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(messageOverview.imageUrl),
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/chat',
                    arguments: {
                      'isGroup': messageOverview.isGroup,
                      'otherId': messageOverview.id,
                      'name': messageOverview.name
                    },
                  );
                },
              );
            },
          );
        }
      ),
    );
  }
}
