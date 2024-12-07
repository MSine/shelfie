import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/discovery_screen.dart';
import 'screens/book_detail_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/messages_screen.dart';
import 'screens/profile_screen.dart';
import 'widgets/navbar_bottom.dart';
import 'screens/search_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shelfie',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/nav': (context) => MainNavigationScreen(),
        '/bookDetail': (context) => BookDetailScreen(
          title: 'title',//title: ModalRoute.of(context)!.settings.arguments['title'],
          author: 'author',//author: ModalRoute.of(context)!.settings.arguments['author'],
        ),
        '/chat': (context) => MessagesListScreen(),
      },
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  @override
  _MainNavigationScreenState createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 2; // Default to HomeScreen

  final List<Widget> _screens = [
    SearchScreen(),
    DiscoveryScreen(),
    HomeScreen(),
    MessagesListScreen(),
    ProfileScreen(),
  ];

  void _onNavBarTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavBarTap,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onNavBarTap(2), // Home button tap
        child: Icon(Icons.home, size: 32),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
