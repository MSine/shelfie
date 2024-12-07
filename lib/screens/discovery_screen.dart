import 'package:flutter/material.dart';
import '../widgets/book_card.dart';

class DiscoveryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shelfie"),
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
