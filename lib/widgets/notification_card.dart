import 'package:flutter/material.dart';
import '../models/notification_model.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;

  const NotificationCard({
    Key? key,
    required this.notification
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: notification.group == null
            ? Text("${notification.user.name} wants to match with you")
            : Text("${notification.user.name} wants to join your group: ${notification.group?.name} "),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/notificationDetails',
            arguments: {'notification': notification},
          );
        },
      ),
    );
  }
}
