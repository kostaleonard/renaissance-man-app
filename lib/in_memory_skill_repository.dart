//TODO docstrings

import 'package:renaissance_man/skill.dart';
import 'package:renaissance_man/skill_repository.dart';

class InMemorySkillRepository extends SkillRepository {
  final _skills =
      <Skill>[]; //TODO consider a better data structure once we see what kinds of operations the methods need
  // TODO common operations:
  // - (createSkill) Add a skill at the top of the display order (shown first)
  // - (createSkill) Find the next available ID to give a skill
  // - (createSkill) Find a skill with the same name, if any, to prevent duplicates
  // - (readSkills) Get the next subset of skills to be displayed on screen (order by display order)
  // - (updateSkill) Find the skill object in the repository
  // - (deleteSkill) Find the skill object in the repository
  // - (deleteSkill) Remove a skill from the repository, correcting the display order of other elements
  var _nextAvailableId = 0;
  final Duration withDelay;

  InMemorySkillRepository({this.withDelay = Duration.zero});

  @override
  Future<Skill> createSkill(String name) {
    final skill = Skill(id: _nextAvailableId, name: name);
    _nextAvailableId++;
    _skills.add(skill); //TODO this should be prepend
    return Future.delayed(withDelay, () => skill);
  }

  @override
  Future<List<Skill>> readSkills({int? limit, int skip = 0}) {
    final skillsAfterSkip = _skills.skip(skip);
    if (limit == null) {
      return Future.delayed(withDelay, () => skillsAfterSkip.toList());
    }
    return Future.delayed(
        withDelay, () => skillsAfterSkip.take(limit).toList());
  }

  @override
  Future<Skill> updateSkill(int id) {
    // TODO not sure what update needs to look like yet
    throw UnimplementedError();
  }

  @override
  Future<void> deleteSkill(int id) {
    final lengthBeforeRemove = _skills.length;
    _skills.removeWhere((skill) => skill.id == id);
    if (_skills.length == lengthBeforeRemove) {
      throw ArgumentError('The repository does not contain skill $id');
    }
    return Future.delayed(withDelay, () => null);
  }
}
