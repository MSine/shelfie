import 'package:shelfie_app/main.dart';
import 'package:shelfie_app/models/user_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/group_model.dart';

class PromotedService {
  static Future<Promotable> getPromotable() async {
    final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/api/match/get/group/${MyApp.userId}')
    );
    final data = json.decode(response.body);
    return Group.fetchGroup(data['id']);
  }
  static Future<Promotable> getNextPromotable() {
    return User.fetchUser(2);
  }

  Future<Group> getGroup() async {
    final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/api/match/get/group/${MyApp.userId}')
    );
    return Group.fetchGroup(json.decode(response.body)['id']);
  }

  Future<User> getUser() async {
    final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/api/match/get/user/${MyApp.userId}')
    );
    return User.fetchUser(json.decode(response.body)['id']);
  }
}
