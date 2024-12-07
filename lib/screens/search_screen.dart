import 'package:flutter/material.dart';
import '../models/book_model.dart';
import '../widgets/book_card.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<String> _recentSearches = [
    "The Hobbit",
    "1984",
    "Dune",
    "Pride and Prejudice",
    "The Catcher in the Rye"
  ];

  final List<String> _hotSearches = [
    "A Song of Ice and Fire",
    "Harry Potter",
    "The Great Gatsby",
    "Moby Dick",
    "The Alchemist"
  ];

  final List<Book> _books = [
    Book(
      title: "The Hobbit",
      author: "J.R.R. Tolkien",
      imageUrl: "https://via.placeholder.com/50x70",
      rating: 3.5,
    ),
    Book(
      title: "1984",
      author: "George Orwell",
      imageUrl: "https://via.placeholder.com/50x70",
      rating: 3.5,
    ),
    Book(
      title: "Dune",
      author: "Frank Herbert",
      imageUrl: "https://via.placeholder.com/50x70",
      rating: 3.5,
    ),
    Book(
      title: "Pride and Prejudice",
      author: "Jane Austen",
      imageUrl: "https://via.placeholder.com/50x70",
      rating: 3.5,
    ),
    Book(
      title: "The Catcher in the Rye",
      author: "J.D. Salinger",
      imageUrl: "https://via.placeholder.com/50x70",
      rating: 3.5,
    ),
  ];

  List<Book> _filteredBooks = [];

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredBooks.clear();
      } else {
        _filteredBooks = _books
            .where((book) =>
        book.title.toLowerCase().contains(query.toLowerCase()) ||
            book.author.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search for books...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _onSearchChanged,
            ),
          ),
          // Recent and Hot Searches or Filtered Books
          Expanded(
            child: _searchQuery.isEmpty
                ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Recent Searches
                  const Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Your Recent Searches",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _recentSearches.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_recentSearches[index]),
                        onTap: () {
                          _searchController.text = _recentSearches[index];
                          _onSearchChanged(_recentSearches[index]);
                        },
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  // Hot Searches
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Today's Hot Searches",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _hotSearches.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_hotSearches[index]),
                        onTap: () {
                          _searchController.text = _hotSearches[index];
                          _onSearchChanged(_hotSearches[index]);
                        },
                      );
                    },
                  ),
                ],
              ),
            )
                : ListView.builder(
              itemCount: _filteredBooks.length,
              itemBuilder: (context, index) {
                return BookCard(book: _filteredBooks[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
