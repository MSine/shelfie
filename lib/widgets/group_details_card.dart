import 'package:flutter/material.dart';
import 'package:shelfie_app/widgets/user_card.dart';
import '../models/group_model.dart';

class GroupDetailsCard extends StatelessWidget {
  final Group group;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const GroupDetailsCard({
    Key? key,
    required this.group,
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
          // Group Name
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              group.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          // Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              group.description,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ),
          SizedBox(height: 10),
          // Group Stats
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Members: ${group.members.length}",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Activity Level: ${group.activityLevel}",
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
                  child: Text("Move on"),
                ),
                ElevatedButton(
                  onPressed: onAccept,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: Text("Request"),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Members",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: group.members.length,
            itemBuilder: (context, index) {
              return UserCard(user: group.members[index],);
            },
          ),
        ],
      ),
    );
  }
}
