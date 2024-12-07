import 'package:flutter/material.dart';
import '../models/review_model.dart';
import '../widgets/review_card.dart';

class ProfileScreen extends StatelessWidget {
  final String profileImage = "https://cataas.com/cat";
  final String name = "John Doe";
  final String favoriteGenre = "Fantasy";
  final String about = "Avid reader who loves exploring new worlds through books. Always on the lookout for a thrilling adventure or a heartwarming story.";
  final List<Review> reviews = [
    Review(
      bookTitle: "The Hobbit",
      author: "J.R.R. Tolkien",
      reviewText: "An incredible journey through Middle-earth! A must-read for fantasy lovers.",
      rating: 5.0,
    ),
    Review(
      bookTitle: "To Kill a Mockingbird",
      author: "Harper Lee",
      reviewText: "A powerful and thought-provoking novel that explores deep societal issues.",
      rating: 4.5,
    ),
    Review(
      bookTitle: "1984",
      author: "George Orwell",
      reviewText: "Chilling and gripping. A timeless classic that feels all too relevant.",
      rating: 4.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 220,
                  color: Colors.blue[100],
                ),
                Positioned(
                  top: 10,
                  left: MediaQuery.of(context).size.width / 2 - 100,
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage(profileImage),
                  ),
                ),
              ],
            ),
            SizedBox(height: 60),
            // Name and Descriptions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Favorite Genre: $favoriteGenre",
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "About Me:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    about,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            // Reviews Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Previous Reviews",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                return ReviewCard(review: reviews[index]);
              },
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
