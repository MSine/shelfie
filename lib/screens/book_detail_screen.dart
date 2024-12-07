import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:convert'; // For API parsing
import 'package:http/http.dart' as http; // For API calls
import '../models/book_model.dart';
import '../models/review_model.dart';
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
    _bookFuture = fetchBook(widget.bookId);
  }

  Future<Book> fetchBook(int bookId) async {
    // Simulate a network delay
    await Future.delayed(Duration(seconds: 2));

    // Return mock data
    return Book(
      title: "The Great Gatsby",
      author: "F. Scott Fitzgerald",
      imageUrl: "https://cataas.com/cat",
      rating: 4.5,
      reviews: [
        ReviewBook(
          username: "JaneDoe",
          rating: 4.0,
          text: "An absolute classic. Loved the characters and setting!",
        ),
        ReviewBook(
          username: "JohnSmith",
          rating: 5.0,
          text: "One of the best books I've ever read. A masterpiece!",
        ),
        ReviewBook(
          username: "Reader101",
          rating: 3.5,
          text: "Good book, but a bit overrated in my opinion.",
        ),
      ],
    );
    /*Future<Book> fetchBook(int bookId) async {
      final response = await http.get(Uri.parse('api/book/$bookId'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Book.fromJson(data);
      } else {
        throw Exception('Failed to load book details');
      }
    }*/
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
                Image.network(
                  book.imageUrl,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 16),
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
