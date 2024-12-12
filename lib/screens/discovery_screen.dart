import 'package:flutter/material.dart';
import '../widgets/book_card.dart';
import '../models/book_model.dart';
import 'dart:math';

class DiscoveryScreen extends StatelessWidget {
  var rng = Random();
  late List<Future<Book>> books;


  @override
  Widget build(BuildContext context) {
    books = List.generate(20, (index) => Book.fetchBook(rng.nextInt(10000)));
    return Scaffold(
      appBar: AppBar(
        title: Text("Discovery"),
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: books.length,
          itemBuilder: (context, index) {
            return FutureBuilder(
              future: books[index],
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData) {
                  return Center(child: Text("Notifications not available"));
                }

                final book = snapshot.data!;
                return BookCard(book: book);
              },
            );
          },
        ),
      )
    );
  }
}
