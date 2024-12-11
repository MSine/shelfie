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

  Future<void> _getNextItem() async {
    setState(() {
      _promotable = PromotedService.getNextPromotable();
    });
  }

  void _handleAccept() {
    // Logic for accepting the group
    _getNextItem();
  }

  void _handleDecline() {
    // Logic for declining the group
    _getNextItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shelfie"),
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
                onAccept: _handleAccept,
                onDecline: _handleDecline,
              ),
            );
          }
        }
      ),
    );
  }
}