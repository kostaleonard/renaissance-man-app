class User {
  final int id;
  final String emailAddress;
  final DateTime createdAt;
  final List<int> skillIds;

  User(
      {required this.id,
      required this.emailAddress,
      createdAt,
      skillIds})
      : createdAt = createdAt ?? DateTime.now(),
        skillIds = skillIds ?? [];

  @override
  String toString() {
    return emailAddress;
  }

  @override
  bool operator ==(Object other) => other is User && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
