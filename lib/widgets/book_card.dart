import 'package:flutter/material.dart';
import '../models/book_model.dart';

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(book.imageUrl),
        title: Text(book.title),
        subtitle: Text("By ${book.author}"),
        trailing: Text("${book.rating.toStringAsFixed(1)} ★"),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/bookDetail',
            arguments: {'title': book.title, 'author': book.author},
          );
        },
      ),
    );
  }
}
