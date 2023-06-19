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

  test('createSkill allows multiple skills to have the same name', () async {
    final repository = InMemorySkillRepository();
    final skill1 = await repository.createSkill('Piano');
    final skill2 = await repository.createSkill('Piano');
    final skills = await repository.readSkills();
    expect(skills, [skill2, skill1]);
  });

  test('readSkills returns skills in order', () async {
    final repository = InMemorySkillRepository();
    final skill1 = await repository.createSkill('Piano');
    final skill2 = await repository.createSkill('Cooking');
    final skill3 = await repository.createSkill('Running');
    final skills = await repository.readSkills();
    expect(skills, [skill3, skill2, skill1]);
  });

  test('readSkills returns skills up to limit', () async {
    final repository = InMemorySkillRepository();
    final _ = await repository.createSkill('Piano');
    final skill2 = await repository.createSkill('Cooking');
    final skill3 = await repository.createSkill('Running');
    final skills = await repository.readSkills(limit: 2);
    expect(skills, [skill3, skill2]);
  });

  test('readSkills returns skills with skip', () async {
    final repository = InMemorySkillRepository();
    final skill1 = await repository.createSkill('Piano');
    final skill2 = await repository.createSkill('Cooking');
    final _ = await repository.createSkill('Running');
    final skills = await repository.readSkills(skip: 1);
    expect(skills, [skill2, skill1]);
  });

  test('readSkills returns skills with skip and limit', () async {
    final repository = InMemorySkillRepository();
    var _ = await repository.createSkill('Piano');
    final skill2 = await repository.createSkill('Cooking');
    _ = await repository.createSkill('Running');
    final skills = await repository.readSkills(limit: 1, skip: 1);
    expect(skills, [skill2]);
  });

  test('deleteSkill removes skill from repository', () async {
    final repository = InMemorySkillRepository();
    final skill1 = await repository.createSkill('Piano');
    final skill2 = await repository.createSkill('Cooking');
    final skill3 = await repository.createSkill('Running');
    await repository.deleteSkill(skill2.id);
    final skills = await repository.readSkills();
    expect(skills, [skill3, skill1]);
  });

  test('deleteSkill throws an error if the skill does not exist', () async {
    final repository = InMemorySkillRepository();
    final skill = await repository.createSkill('Piano');
    await repository.deleteSkill(skill.id);
    expect(() async => await repository.deleteSkill(skill.id),
        throwsArgumentError);
  });

  test('Initializing the repository with a delay causes delayed operations',
      () async {
    final repository =
        InMemorySkillRepository(withDelay: const Duration(milliseconds: 100));
    DateTime start = DateTime.now();
    final _ = await repository.createSkill('Piano');
    DateTime end = DateTime.now();
    final minimumDifferenceWithErrorBuffer =
        repository.withDelay - const Duration(milliseconds: 10);
    expect(
        end.difference(start).compareTo(minimumDifferenceWithErrorBuffer) > 0,
        isTrue);
  });
}
