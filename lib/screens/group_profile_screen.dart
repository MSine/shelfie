import 'package:flutter/material.dart';
import 'package:shelfie_app/widgets/user_card.dart';
import '../main.dart';
import '../models/group_model.dart';
import '../models/user_model.dart';

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


  void _editProfile(int id, String name, String description, String image) async {
    Group.postEditGroup(id, name, description, image);
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _groupFuture = Group.fetchGroup(widget.groupId);
    });
  }

  void _openEditDialog(int id, String name, String description, String image) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Group"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Name
              const Text(
                'Group Name:',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold
                ),
              ),
              TextFormField(
                initialValue: name,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: "Write the group name",
                ),
                onChanged: (value) {
                  name = value;
                },
              ),
              // Image
              const Text(
                'Group Profile Photo:',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold
                ),
              ),
              TextFormField(
                initialValue: image,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: "Enter a url",
                ),
                onChanged: (value) {
                  image = value;
                },
              ),
              // Description
              const Text(
                'About Your Group:',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold
                ),
              ),
              TextFormField(
                initialValue: description,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Write about yourself",
                ),
                onChanged: (value) {
                  description = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _editProfile(id, name, description, image);
              },
              child: Text("Send"),
            ),
          ],
        );
      },
    );
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
                SizedBox(height: 16),
                // Name and Descriptions
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            group.name,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          if (MyApp.userId == group.adminId) IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => _openEditDialog(
                              group.id,
                              group.name,
                              group.description,
                              group.imageUrl
                            ),
                          ),
                        ],
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
                  child: Row(
                    children: [
                      const Text(
                        "Members",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      if (MyApp.userId == group.adminId) IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {},
                      ),
                    ],
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
