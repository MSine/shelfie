class Group {
  final String id;
  final String name;
  final String description;
  final List<String> members;
  final String activityLevel; // Example: "Very Active"
  final int onlineUsers; // Number of users online

  Group({
    required this.id,
    required this.name,
    required this.description,
    required this.members,
    required this.activityLevel,
    required this.onlineUsers,
  });
}
