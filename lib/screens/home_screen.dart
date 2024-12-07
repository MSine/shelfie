import 'package:flutter/material.dart';
import '../widgets/book_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shelfie"),
        actions: [
          IconButton(
            icon: Icon(Icons.chat),
            onPressed: () {
              Navigator.pushNamed(context, '/chat');
            },
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          BookCard(
            title: "Book Title",
            author: "Author Name",
            imageUrl: "https://cataas.com/cat",
            rating: 4.5,
          ),
          // Add more BookCards dynamically
        ],
      ),
    );
  }
}
