import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/book_model.dart';
import '../widgets/review_card.dart';

class BookDetailScreen extends StatefulWidget {
  final int bookId;

  const BookDetailScreen({Key? key, required this.bookId}) : super(key: key);

  @override
  _BookDetailScreenState createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  late Future<Book> _bookFuture;

  @override
  void initState() {
    super.initState();
    _bookFuture = Book.fetchBook(widget.bookId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Details"),
      ),
      body: FutureBuilder<Book>(
        future: _bookFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return Center(child: Text("Book details not available"));
          }

          final book = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Book Cover
                /*Image.network(
                  book.imageUrl,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 16),*/
                // Title and Author
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "by ${book.author}",
                        style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                      ),
                      SizedBox(height: 16),
                      // Rating
                      Row(
                        children: List.generate(
                          5,
                              (index) => Icon(
                            index < book.rating.round()
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                // Reviews
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Reviews",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: book.reviews?.length,
                  itemBuilder: (context, index) {
                    return ReviewCard(review: book.reviews?[index]);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
