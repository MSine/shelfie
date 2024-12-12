import 'package:shelfie_app/main.dart';
import 'package:shelfie_app/models/user_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/group_model.dart';

class PromotedService {
  static Future<Promotable> getPromotable() async {
    return getUser();
  }

  static Future<Promotable> getNextPromotable() {
    return getGroup();
  }

  static Future<Group> getGroup() async {
    final response = await http.get(
        Uri.parse('${MyApp.serverIp}/api/match/get/group/${MyApp.userId}')
    );
    return Group.fetchGroup(json.decode(response.body)['id']);
  }

  static Future<User> getUser() async {
    final response = await http.get(
        Uri.parse('${MyApp.serverIp}/api/match/get/user/${MyApp.userId}')
    );
    return User.fetchUser(json.decode(response.body)['id']);
  }
}
