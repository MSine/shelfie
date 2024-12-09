import 'package:shelfie_app/models/user_model.dart';

import '../models/group_model.dart';

class PromotedGroupsService {
  static List<Group> getPromotedGroups() {
    return [
      Group(
        id: '1',
        name: 'Book Lovers',
        imageUrl: 'https://cataas.com/cat',
        description: 'A group for people who love reading all genres of books.',
        activityLevel: 'Very Active',
        members: [
          User(id: 1,
              name: 'Alice',
              description: 'Nerd',
              imageUrl: 'https://cataas.com/cat',
              genre: 'Horror'),
          User(id: 2,
              name: 'Bob',
              description: 'Nerdier',
              imageUrl: 'https://cataas.com/cat',
              genre: 'Sci-fi'),
          User(id: 3,
              name: 'Charlie',
              description: 'Nerdiest',
              imageUrl: 'https://cataas.com/cat',
              genre: 'Documentaries'),
        ],
      ),
      Group(
        id: '2',
        name: 'Thriller Enthusiasts',
        imageUrl: 'https://cataas.com/cat',
        description: 'Discuss the best thriller novels and movies here!',
        activityLevel: 'Moderately Active',
        members: [
          User(id: 1,
              name: 'Dave',
              description: 'Nerd',
              imageUrl: 'https://cataas.com/cat',
              genre: 'Horror'),
          User(id: 2,
              name: 'Eve',
              description: 'Nerdier',
              imageUrl: 'https://cataas.com/cat',
              genre: 'Sci-fi'),
          User(id: 3,
              name: 'Frank',
              description: 'Nerdiest',
              imageUrl: 'https://cataas.com/cat',
              genre: 'Documentaries'),
        ],
      ),
    ];
  }
}
