//TODO docstrings

import 'package:renaissance_man/skill.dart';
import 'package:renaissance_man/repository.dart';

class InMemoryRepository extends Repository {
  final _skills = <Skill>[]; // TODO would like data structure with O(1) prepend
  var _nextAvailableId = 0;
  final Duration withDelay;

  InMemoryRepository({this.withDelay = Duration.zero});

  @override
  Future<Skill> createSkill(String name) {
    final skill = Skill(id: _nextAvailableId, name: name);
    _nextAvailableId++;
    _skills.insert(0, skill);
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
