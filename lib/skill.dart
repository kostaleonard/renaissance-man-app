/// Contains the representation of a skill that the user has created.

class Skill {
  final int id;
  final String name;
  final DateTime createdAt;
  int minutesInvested;

  Skill({required this.id, required this.name, createdAt})
      : createdAt = createdAt ?? DateTime.now(),
        minutesInvested = 0;

  @override
  String toString() {
    return name;
  }
}
