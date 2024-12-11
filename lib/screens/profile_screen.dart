import 'package:flutter/material.dart';
import 'package:shelfie_app/models/user_model.dart';
import '../main.dart';
import '../widgets/review_card.dart';

class ProfileScreen extends StatefulWidget {
  final int userId;

  const ProfileScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<User> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = User.fetchUser(widget.userId);
  }

  void _editProfile(String name, String description, String image) async {
    User.postEdit(name, description, image);
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _userFuture = User.fetchUser(widget.userId);
    });
  }

  void _openEditDialog(String name, String description, String image) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Profile"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Name
              const Text(
                'Your name:',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold
                ),
              ),
              TextFormField(
                initialValue: name,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: "Write about yourself",
                ),
                onChanged: (value) {
                  name = value;
                },
              ),
              // Image
              const Text(
                'Your Profile Photo:',
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
                'About you:',
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
                _editProfile(name, description, image);
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
      body: FutureBuilder<User>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return Center(child: Text("Book details not available"));
          }

          final user = snapshot.data!;
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
                        backgroundImage: NetworkImage(user.imageUrl),
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
                            user.name,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          if (MyApp.userId == widget.userId) IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => _openEditDialog(user.name, user.description, user.imageUrl),
                          ),
                        ],
                      ),

                      SizedBox(height: 8),
                      Text(
                        "Favorite Genre: ${user.genre}",
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "About Me:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        user.description,
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
                    "Previous Reviews",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: user.reviews?.length,
                  itemBuilder: (context, index) {
                    return ReviewCard(review: user.reviews?[index]);
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
