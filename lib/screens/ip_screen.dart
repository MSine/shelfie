import 'package:flutter/material.dart';
import 'package:shelfie_app/main.dart';

import '../models/user_model.dart';

class IpScreen extends StatefulWidget {
  @override
  _IpScreenState createState() => _IpScreenState();
}

class _IpScreenState extends State<IpScreen> {
  String _ip = '';

  @override
  void initState() {
    super.initState();
  }

  void _register() async {
    if (_ip.isEmpty) {
      return;
    }
    MyApp.serverIp = "http://${_ip}";

    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(child: Text("Welcome To Shelfie"))
      ),
      floatingActionButton: ElevatedButton(
        child: Text("Continue"),
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
                  'Enter Your Server IP:',
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
                    _ip = value;
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
