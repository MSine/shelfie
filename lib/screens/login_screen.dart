import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shelfie_app/main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _handleSignIn() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        final String? idToken = googleSignInAuthentication.idToken;
        //print(idToken);
        MyApp.userId = 1;
        Navigator.pushReplacementNamed(context, '/home');
        return;
        final response = await http.post(
          Uri.parse('https://10.0.2.2:8080/api/auth'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'idToken': idToken}),
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          // Register
          if (responseData['exists'] == false) {
            Navigator.pushReplacementNamed(context, '/register',
              arguments: {
                'userId': responseData['userId'],
              },
            );
          }
          // Login
          else {
            MyApp.userId = responseData['userId'];
            Navigator.pushReplacementNamed(context, '/home');
          }
        } else {
          throw Exception('Failed to authenticate with back-end. Status code: ${response.statusCode}');
        }
      }
    } catch (error) {
      print(error);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome to Shelfie!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _handleSignIn,
                child: Text("Login with Google"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
