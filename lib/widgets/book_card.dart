import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final String title;
  final String author;
  final String imageUrl;
  final double rating;

  BookCard({
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(imageUrl),
        title: Text(title),
        subtitle: Text("By $author"),
        trailing: Text("${rating.toStringAsFixed(1)} ★"),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/bookDetail',
            arguments: {'title': title, 'author': author},
          );
        },
      ),
    );
  }
}
