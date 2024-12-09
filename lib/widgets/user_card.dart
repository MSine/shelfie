import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(user.imageUrl),
        title: Text(user.name),
        subtitle: user.genre != "" ? Text("Genre: ${user.genre}") : null,
        onTap: () {
          Navigator.pushNamed(
            context,
            '/userProfile',
            arguments: {'userId': user.id},
          );
        },
      ),
    );
  }
}