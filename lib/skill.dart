/// Contains the representation of a skill that the user has created.

class Skill {
  final int id;
  final String name;
  final DateTime createdAt;
  int minutesInvested; //TODO this should just be a collection of all the practice sessions and schedules, then the app will dynamically calculate time spent

  Skill({required this.id, required this.name, createdAt})
      : createdAt = createdAt ?? DateTime.now(),
        minutesInvested = 0;

  @override
  String toString() {
    return name;
  }
}

class PracticePeriod {
  final DateTime start;
  final DateTime end;
  final CronSche
}
