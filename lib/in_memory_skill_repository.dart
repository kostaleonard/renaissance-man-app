//TODO docstrings

import 'package:renaissance_man/skill.dart';
import 'package:renaissance_man/skill_repository.dart';

class InMemorySkillRepository extends SkillRepository {
  final _skills = <Skill>[]; //TODO consider a better data structure once we see what kinds of operations the methods need
  // TODO common operations:
  // - (createSkill) Add a skill at the top of the display order (shown first)
  // - (createSkill) Find the next available ID to give a skill
  // - (createSkill) Find a skill with the same name, if any, to prevent duplicates
  // - (readSkills) Get the next subset of skills to be displayed on screen (order by display order)
  // - (updateSkill) Find the skill object in the repository
  // - (deleteSkill) Find the skill object in the repository
  // - (deleteSkill) Remove a skill from the repository, correcting the display order of other elements
  var _nextAvailableId = 0;

  @override
  Future<Skill> createSkill(String name) {
    // TODO throw error if name not unique
    final skill = Skill(id: _nextAvailableId, name: name, createdAt: DateTime.now(), displayOrder: 0);
  }

  @override
  Future<List<Skill>> readSkills({int? limit, int skip = 0}) {
    // TODO SELECT * FROM skills WHERE user=user ORDER BY displayOrder LIMIT limit SKIP skip
    // TODO: implement readSkills
    throw UnimplementedError();
  }

  @override
  Future<Skill> updateSkill(Skill skill) {
    // TODO: implement updateSkill
    throw UnimplementedError();
  }

  @override
  Future<void> deleteSkill(Skill skill) {
    // TODO: implement deleteSkill
    throw UnimplementedError();
  }
}
