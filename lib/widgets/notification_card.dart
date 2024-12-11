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
        title: Text("${notification.user.name} wants to match with you"),
        //trailing: Text("${book.rating.toStringAsFixed(1)} ★"),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/notificationDetail',
            arguments: {'notification': notification},
          );
        },
      ),
    );
  }
}
