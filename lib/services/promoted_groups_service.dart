import 'package:shelfie_app/models/user_model.dart';

import '../models/group_model.dart';

class PromotedService {
  static Future<Promotable> getPromotable() {
    return Group.fetchGroup(1);
  }
  static Future<Promotable> getNextPromotable() {
    return User.fetchUser(2);
  }
}
