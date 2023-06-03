/// Tests in_memory_skill_repository.dart.

import 'package:flutter_test/flutter_test.dart';
import 'package:renaissance_man/in_memory_skill_repository.dart';

void main() {
  test('Repository starts with no skills', () async {
    final repository = InMemorySkillRepository();
    final skills = await repository.readSkills();
    expect(skills.isEmpty, true);
  });

  test('createSkill adds a skill to the repository', () async {
    final repository = InMemorySkillRepository();
    final skill = await repository.createSkill('Piano');
    final skills = await repository.readSkills();
    expect(skills.length, 1);
    expect(skills[0], skill);
  });

  test('createSkill gives skill a unique ID', () async {
    final repository = InMemorySkillRepository();
    // TODO
  });
}
