/// Contains the representation of a skill that the user has created.

class Skill {
  final int id;
  final String name;
  final DateTime createdAt;
  final List<int> weeklyPracticeScheduleIds;

  Skill(
      {required this.id,
      required this.name,
      createdAt,
      weeklyPracticeScheduleIds})
      : createdAt = createdAt ?? DateTime.now(),
        weeklyPracticeScheduleIds = weeklyPracticeScheduleIds ?? [];

  @override
  String toString() {
    return name;
  }

  @override
  bool operator ==(Object other) => other is Skill && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
