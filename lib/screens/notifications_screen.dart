import 'package:flutter/material.dart';
import 'package:shelfie_app/widgets/notification_card.dart';
import '../models/notification_model.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late Future<List<NotificationModel>> _notificationsFuture;

  @override
  void initState() {
    super.initState();
    _notificationsFuture = NotificationModel.fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body: FutureBuilder<List<NotificationModel>>(
        future: _notificationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return Center(child: Text("Notifications not available"));
          }

          final notifications = snapshot.data!;
          if (notifications.isEmpty) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: Text(
                "No Notifications",
                style: TextStyle(fontSize: 18),
              ),
          );
          }
          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              return NotificationCard(notification: notifications[index]);
            },
          );
        }
      ),
    );
  }
}
