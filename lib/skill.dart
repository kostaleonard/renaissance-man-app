/// Contains the representation of a skill that the user has created.

class Skill {
  final int id;
  final String name;
  final int displayOrder; // TODO is displayOrder necessary? Or do we want to use a linked list structure?
  final DateTime createdAt;

  const Skill(
      {required this.id,
      required this.name,
      required this.displayOrder,
      required this.createdAt});
}
