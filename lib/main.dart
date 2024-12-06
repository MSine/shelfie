import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/book_detail_screen.dart';
import 'screens/chat_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shelfie',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/bookDetail': (context) => BookDetailScreen(
          title: 'title',//title: ModalRoute.of(context)!.settings.arguments['title'],
          author: 'author',//author: ModalRoute.of(context)!.settings.arguments['author'],
        ),
        '/chat': (context) => ChatScreen(),
      },
    );
  }
}
