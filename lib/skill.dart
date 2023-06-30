/// Contains the representation of a skill that the user has created.

class Skill {
  final int id;
  final String name;
  final DateTime createdAt;
  final List<int> weeklyPracticeScheduleIds; //TODO should we keep the objects or the IDs from the database? Then load dynamically. Because the actual Skill object in the database will only have the IDs.

  Skill({required this.id, required this.name, createdAt, recurringWeeklyPractices})
      : createdAt = createdAt ?? DateTime.now(),
        weeklyPracticeScheduleIds = recurringWeeklyPractices ?? [];

  @override
  String toString() {
    return name;
  }
}
