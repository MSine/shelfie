import 'package:flutter/material.dart';
import '../models/book_model.dart';

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({
    Key? key,
    required this.book
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: Container(
            height: 60.0,
            width: 40.0,
            color: Color(0xffffff),
            child: Image.network(book.imageUrl),
          ),
        ),
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
