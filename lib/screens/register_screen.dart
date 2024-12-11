import 'package:flutter/material.dart';
import 'package:shelfie_app/main.dart';

import '../models/user_model.dart';

class RegisterScreen extends StatefulWidget {
  final int userId;

  const RegisterScreen({
    super.key,
    required this.userId
  });

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _name = '';
  String _description = '';
  String _imageUrl = '';

  @override
  void initState() {
    super.initState();
  }

  void _register() async {
    if (_name.isEmpty || _description.isEmpty) {
      return;
    }

    User.postEdit(_name, _description, _imageUrl);

    MyApp.userId = widget.userId;
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Register")
      ),
      floatingActionButton: ElevatedButton(
        child: Text("Register"),
        onPressed: _register,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 64,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                const Text(
                  'Enter Your Profile Name:',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold
                  ),
                ),
                TextField(
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: "Name",
                  ),
                  onChanged: (value) {
                    _name = value;
                  },
                ),
                SizedBox(height: 32),
                // Image
                const Text(
                  'Enter Profile Photo Url:',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold
                  ),
                ),
                TextField(
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: "Image Url",
                  ),
                  onChanged: (value) {
                    _imageUrl = value;
                  },
                ),
                SizedBox(height: 32),
                // Description
                const Text(
                  'Write about yourself:',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold
                  ),
                ),
                TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "Description\nOf\nYourself",
                  ),
                  onChanged: (value) {
                    _description = value;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
