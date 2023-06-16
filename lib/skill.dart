/// Contains the representation of a skill that the user has created.

class Skill {
  final int id;
  final String name;
  final DateTime createdAt;

  Skill({required this.id, required this.name, createdAt})
      : createdAt = createdAt ?? DateTime.now();

  @override
  String toString() {
    return name;
  }
}
