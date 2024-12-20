import 'package:flutter/material.dart';
import 'package:shelfie_app/widgets/review_card.dart';
import '../models/user_model.dart';

class UserDetailsCard extends StatelessWidget {
  final User user;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const UserDetailsCard({
    Key? key,
    required this.user,
    required this.onAccept,
    required this.onDecline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                    .width / 2 - 116,
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: NetworkImage(user.imageUrl),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          // Group Name
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
                  onPressed: onDecline,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: Text(
                    "Decline",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  onPressed: onAccept,
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
    );
  }
}
