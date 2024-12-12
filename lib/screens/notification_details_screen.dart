import 'package:flutter/material.dart';
import 'package:shelfie_app/models/notification_model.dart';
import 'package:shelfie_app/models/user_model.dart';
import '../models/group_model.dart';
import '../widgets/review_card.dart';

class NotificationDetailsScreen extends StatefulWidget {
  final NotificationModel notification;

  const NotificationDetailsScreen({
    Key? key,
    required this.notification
  }) : super(key: key);

  @override
  _NotificationDetailsScreenState createState() => _NotificationDetailsScreenState();
}

class _NotificationDetailsScreenState extends State<NotificationDetailsScreen> {

  void _onAccept() {
    if (widget.notification.group == null) {
      User.postMatch(widget.notification.user.id, false);
    }
    else {
      Group.postMatch(widget.notification.user.id, widget.notification.group!.id, false);
    }
    Navigator.pop(context);
  }

  void _onDecline() {
    if (widget.notification.group == null) {
      User.postMatch(widget.notification.user.id, true);
    }
    else {
      Group.postMatch(widget.notification.user.id, widget.notification.group!.id, true);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final Future<User> _userFuture = User.fetchUser(widget.notification.user.id);
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
      ),
      body: FutureBuilder<User>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error loading promotable");
          } else if (!snapshot.hasData) {
            return Text("No promotable available");
          }
          final user = snapshot.data!;
          return SingleChildScrollView(
            child: Card(
              elevation: 4,
              margin: EdgeInsets.all(16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Image
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 220,
                        color: Colors.blue[100],
                      ),
                      Positioned(
                        top: 10,
                        left: MediaQuery
                            .of(context)
                            .size
                            .width / 2 - 100,
                        child: CircleAvatar(
                          radius: 100,
                          backgroundImage: NetworkImage(user.imageUrl),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Name
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      user.name,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // Description
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      user.description,
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Most Read Genre: ${user.genre}",
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Accept/Decline Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: _onDecline,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: Text(
                            "Decline",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _onAccept,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: Text(
                            "Accept",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Reviews",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: user.reviews?.length,
                    itemBuilder: (context, index) {
                      return ReviewCard(review: user.reviews?[index],);
                    },
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}