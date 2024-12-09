class ReviewUser {
  final String title;
  final String author;
  final String text;
  final double rating;

  ReviewUser({
    required this.title,
    required this.author,
    required this.text,
    required this.rating,
  });

  // Factory constructor to parse JSON data
  factory ReviewUser.fromJson(Map<String, dynamic> json) {
    return ReviewUser(
      title: json['bookTitle'],
      author: json['bookAuthor'] ?? "Unknown",
      text: json['text'],
      rating: json['rating'].toDouble(),
    );
  }
}

class ReviewBook {
  final String username;
  final double rating;
  final String text;

  ReviewBook({
    required this.username,
    required this.rating,
    required this.text,
  });

  // Factory constructor to parse JSON data
  factory ReviewBook.fromJson(Map<String, dynamic> json) {
    return ReviewBook(
      username: json['user name'],
      rating: json['rating'].toDouble(),
      text: json['text'],
    );
  }
}
