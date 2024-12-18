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
    "The Warriors",
    "Apocolocyntosis",
    "Contes Dune Grandmre",
    "Pride and Prejudice",
    "Catchisme Libertin"
  ];

  List<Book> _books = [];

  void _onSearchChanged(String query) async {
    late List<Book> books = [];
    if (query.isEmpty) {
      books = [];
    } else {
      books = await Book.fetchBookSearch(query);
    }
    setState(() {
      _searchQuery = query;
      _books = books;
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
                ],
              ),
            )
                : ListView.builder(
              itemCount: _books.length,
              itemBuilder: (context, index) {
                return BookCard(book: _books[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
