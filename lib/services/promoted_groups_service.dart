import '../models/group_model.dart';

class PromotedGroupsService {
  static List<Group> getPromotedGroups() {
    return [
      Group(
        id: '1',
        name: 'Book Lovers',
        description: 'A group for people who love reading all genres of books.',
        members: ['Alice', 'Bob', 'Charlie'],
        activityLevel: 'Very Active',
        onlineUsers: 10,
      ),
      Group(
        id: '2',
        name: 'Thriller Enthusiasts',
        description: 'Discuss the best thriller novels and movies here!',
        members: ['Dave', 'Eve', 'Frank'],
        activityLevel: 'Moderately Active',
        onlineUsers: 5,
      ),
    ];
  }
}
