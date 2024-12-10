import 'package:flutter/material.dart';
import 'package:shelfie_app/widgets/user_card.dart';
import '../models/group_model.dart';
import '../models/user_model.dart';
import '../widgets/review_card.dart';

class GroupProfileScreen extends StatefulWidget {
  final int groupId;

  const GroupProfileScreen({
    Key? key,
    required this.groupId
  }) : super(key: key);

  @override
  _GroupProfileScreenState createState() => _GroupProfileScreenState();
}

class _GroupProfileScreenState extends State<GroupProfileScreen> {
  late Future<Group> _groupFuture;

  @override
  void initState() {
    super.initState();
    _groupFuture = Group.fetchGroup(widget.groupId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: FutureBuilder<Group>(
          future: _groupFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData) {
              return Center(child: Text("Book details not available"));
            }

            final group = snapshot.data!;
            return SingleChildScrollView(
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
                          backgroundImage: NetworkImage(group.imageUrl),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 60),
                  // Name and Descriptions
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          group.name,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "About Us:",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          group.description,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  // Reviews Section
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
                    itemCount: group.members?.length,
                    itemBuilder: (context, index) {
                      return FutureBuilder<User>(
                        future: group.members?[index],
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text("Error loading user: ${snapshot.error}");
                          } else if (!snapshot.hasData) {
                            return Text("No user data available");
                          } else {
                            return UserCard(
                              user: snapshot.data!,
                            );
                          }
                        },
                      );
                    },
                  ),
                  SizedBox(height: 16),
                ],
              ),
            );
          }
      ),
    );
  }
}
