import 'package:flutter/material.dart';
import 'package:shelfie_app/screens/chat_screen.dart';
import 'package:shelfie_app/screens/group_create_screen.dart';
import 'package:shelfie_app/screens/group_profile_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/discovery_screen.dart';
import 'screens/book_detail_screen.dart';
import 'screens/messages_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/notification_details_screen.dart';
import 'screens/profile_screen.dart';
import 'widgets/navbar_bottom.dart';
import 'screens/search_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static late int userId;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shelfie',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => MainNavigationScreen(),
        '/bookDetail': (context) => BookDetailScreen(
          bookId: (ModalRoute.of(context)!.settings.arguments! as Map)['bookId'],
        ),
        '/chat': (context) => ChatScreen(
          isGroup: (ModalRoute.of(context)!.settings.arguments! as Map)['isGroup'],
          otherId: (ModalRoute.of(context)!.settings.arguments! as Map)['otherId'],
          name: (ModalRoute.of(context)!.settings.arguments! as Map)['name'],
        ),
        '/userProfile': (context) => ProfileScreen(
          userId: (ModalRoute.of(context)!.settings.arguments! as Map)['userId'],
        ),
        '/groupProfile': (context) => GroupProfileScreen(
          groupId: (ModalRoute.of(context)!.settings.arguments! as Map)['groupId'],
        ),
        '/groupCreate': (context) => GroupCreateScreen(),
        '/notifications': (context) => NotificationsScreen(),
        '/notificationDetails': (context) => NotificationDetailsScreen(
          notification: (ModalRoute.of(context)!.settings.arguments! as Map)['notification'],
        ),
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
    MessagesScreen(),
    ProfileScreen(userId: MyApp.userId,),
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
