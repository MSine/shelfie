import 'package:flutter/material.dart';
import '../models/group_model.dart';
import '../widgets/group_details_card.dart';
import '../services/promoted_groups_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Group> _promotedGroups = PromotedGroupsService.getPromotedGroups();
  int _currentIndex = 0;

  void _handleAccept() {
    // Logic for accepting the group
    final acceptedGroup = _promotedGroups[_currentIndex];
    print("Accepted: ${acceptedGroup.name}");
    _moveToNextGroup();
  }

  void _handleDecline() {
    // Logic for declining the group
    print("Declined: ${_promotedGroups[_currentIndex].name}");
    _moveToNextGroup();
  }

  void _moveToNextGroup() {
    setState(() {
      if (_currentIndex < _promotedGroups.length - 1) {
        _currentIndex++;
      } else {
        // No more groups
        _currentIndex = 0;
        // Alternatively, show a message or reload more groups
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: _promotedGroups.isEmpty
            ? Text("No promoted groups available")
            : GroupDetailsCard(
          group: _promotedGroups[_currentIndex],
          onAccept: _handleAccept,
          onDecline: _handleDecline,
        ),
      ),
    );
  }
}
