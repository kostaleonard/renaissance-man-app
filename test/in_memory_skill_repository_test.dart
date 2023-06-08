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
    final skill1 = await repository.createSkill('Piano');
    final skill2 = await repository.createSkill('Cooking');
    final skill3 = await repository.createSkill('Running');
    expect({skill1.id, skill2.id, skill3.id}.length, 3);
  });

  test('createSkill throws an error when a skill with the same name already exists', () async {
    final repository = InMemorySkillRepository();
    //TODO it seems like I shouldn't be making the unused variable name ("_") final
    final _ = await repository.createSkill('Piano');
    expect(() async => await repository.createSkill('Piano'), throwsArgumentError);
  });
}
