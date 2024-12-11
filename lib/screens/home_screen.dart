import 'package:flutter/material.dart';
import 'package:shelfie_app/models/user_model.dart';
import '../widgets/promoted_card.dart';
import '../services/promoted_groups_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Promotable> _promotable;

  @override
  void initState() {
    super.initState();
    setState(() {
      _promotable = PromotedService.getPromotable();
    });
  }

  void _getNextItem() {
    setState(() {
      _promotable = PromotedService.getNextPromotable();
    });
  }

  void _handleAccept(Promotable promotable) {
    // Logic for accepting the group
    if (promotable is User) {
      User.postMatch(promotable.id, false);
    }
    else {
      //Group
    }
    _getNextItem();
  }

  void _handleDecline(Promotable promotable) {
    // Logic for declining the group
    if (promotable is User) {
      User.postMatch(promotable.id, true);
    }
    else {
      //Group
    }
    _getNextItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shelfie"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () => Navigator.pushNamed(context, '/notifications'),
          ),
        ],
      ),
      body: FutureBuilder<Promotable>(
        future: _promotable,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error loading promotable");
          } else if (!snapshot.hasData) {
            return Text("No promotable available");
          } else {
            final promotable = snapshot.data!;
            return SingleChildScrollView(
              child: PromotedCard(
                promotable: promotable,
                onAccept: () => _handleAccept(promotable),
                onDecline: () => _handleDecline(promotable),
              ),
            );
          }
        }
      ),
    );
  }
}