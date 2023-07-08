/// Tests in_memory_repository.dart.

import 'package:flutter_test/flutter_test.dart';
import 'package:renaissance_man/in_memory_repository.dart';
import 'package:renaissance_man/skill.dart';
import 'package:renaissance_man/weekly_practice_schedule.dart';

void main() {
  test('Repository starts with no skills', () async {
    final repository = InMemoryRepository();
    final skills = await repository.readSkills();
    expect(skills.isEmpty, true);
  });

  test('createSkill adds a skill to the repository', () async {
    final repository = InMemoryRepository();
    final skill = await repository.createSkill('Piano');
    final skills = await repository.readSkills();
    expect(skills.length, 1);
    expect(skills[0], skill);
  });

  test('createSkill gives skill a unique ID', () async {
    final repository = InMemoryRepository();
    final skill1 = await repository.createSkill('Piano');
    final skill2 = await repository.createSkill('Cooking');
    final skill3 = await repository.createSkill('Running');
    expect({skill1.id, skill2.id, skill3.id}.length, 3);
  });

  test('createSkill allows multiple skills to have the same name', () async {
    final repository = InMemoryRepository();
    final skill1 = await repository.createSkill('Piano');
    final skill2 = await repository.createSkill('Piano');
    final skills = await repository.readSkills();
    expect(skills, [skill2, skill1]);
  });

  test('readSkill returns skill with matching ID', () async {
    final repository = InMemoryRepository();
    final skill1 = await repository.createSkill('Piano');
    var _ = await repository.createSkill('Cooking');
    _ = await repository.createSkill('Running');
    final skill = await repository.readSkill(skill1.id);
    expect(skill, skill1);
  });

  test('readSkill throws an error if the skill does not exist', () async {
    final repository = InMemoryRepository();
    final skill = await repository.createSkill('Piano');
    expect(() async => await repository.readSkill(skill.id + 1),
        throwsArgumentError);
  });

  test('readSkills returns skills in order', () async {
    final repository = InMemoryRepository();
    final skill1 = await repository.createSkill('Piano');
    final skill2 = await repository.createSkill('Cooking');
    final skill3 = await repository.createSkill('Running');
    final skills = await repository.readSkills();
    expect(skills, [skill3, skill2, skill1]);
  });

  test('readSkills returns skills up to limit', () async {
    final repository = InMemoryRepository();
    final _ = await repository.createSkill('Piano');
    final skill2 = await repository.createSkill('Cooking');
    final skill3 = await repository.createSkill('Running');
    final skills = await repository.readSkills(limit: 2);
    expect(skills, [skill3, skill2]);
  });

  test('readSkills returns skills with skip', () async {
    final repository = InMemoryRepository();
    final skill1 = await repository.createSkill('Piano');
    final skill2 = await repository.createSkill('Cooking');
    final _ = await repository.createSkill('Running');
    final skills = await repository.readSkills(skip: 1);
    expect(skills, [skill2, skill1]);
  });

  test('readSkills returns skills with skip and limit', () async {
    final repository = InMemoryRepository();
    var _ = await repository.createSkill('Piano');
    final skill2 = await repository.createSkill('Cooking');
    _ = await repository.createSkill('Running');
    final skills = await repository.readSkills(limit: 1, skip: 1);
    expect(skills, [skill2]);
  });

  test('updateSkill returns updated skill', () async {
    final repository = InMemoryRepository();
    final skill = await repository.createSkill('Piano');
    final skillUpdate =
        Skill(id: skill.id, name: skill.name, createdAt: DateTime(2023, 1, 1));
    final returnValue = await repository.updateSkill(skillUpdate);
    expect(returnValue, skillUpdate);
  });

  test('updateSkill changes skill data', () async {
    final repository = InMemoryRepository();
    final skill = await repository.createSkill('Piano');
    final skillUpdate =
        Skill(id: skill.id, name: skill.name, createdAt: DateTime(2023, 1, 1));
    await repository.updateSkill(skillUpdate);
    final skills = await repository.readSkills();
    expect(skills.length, 1);
    expect(skills[0].createdAt, skillUpdate.createdAt);
  });

  test('updateSkill does not reorder skills', () async {
    final repository = InMemoryRepository();
    final skill1 = await repository.createSkill('Piano');
    final skill2 = await repository.createSkill('Cooking');
    final skill3 = await repository.createSkill('Running');
    final skillUpdate = Skill(id: skill2.id, name: 'Trombone');
    await repository.updateSkill(skillUpdate);
    final skills = await repository.readSkills();
    expect(skills, [skill3, skillUpdate, skill1]);
  });

  test('updateSkill throws an error if the skill does not exist', () async {
    final repository = InMemoryRepository();
    final skill = await repository.createSkill('Piano');
    final skillUpdate = Skill(
        id: skill.id + 1, name: skill.name, createdAt: DateTime(2023, 1, 1));
    expect(() async => await repository.updateSkill(skillUpdate),
        throwsArgumentError);
  });

  test('deleteSkill removes skill from repository', () async {
    final repository = InMemoryRepository();
    final skill1 = await repository.createSkill('Piano');
    final skill2 = await repository.createSkill('Cooking');
    final skill3 = await repository.createSkill('Running');
    await repository.deleteSkill(skill2.id);
    final skills = await repository.readSkills();
    expect(skills, [skill3, skill1]);
  });

  test('deleteSkill throws an error if the skill does not exist', () async {
    final repository = InMemoryRepository();
    final skill = await repository.createSkill('Piano');
    await repository.deleteSkill(skill.id);
    expect(() async => await repository.deleteSkill(skill.id),
        throwsArgumentError);
  });

  test('Initializing the repository with a delay causes delayed operations',
      () async {
    final repository =
        InMemoryRepository(withDelay: const Duration(milliseconds: 100));
    DateTime start = DateTime.now();
    final _ = await repository.createSkill('Piano');
    DateTime end = DateTime.now();
    final minimumDifferenceWithErrorBuffer =
        repository.withDelay - const Duration(milliseconds: 10);
    expect(
        end.difference(start).compareTo(minimumDifferenceWithErrorBuffer) > 0,
        isTrue);
  });

  test('createWeeklyPracticeSchedule adds a schedule to the repository',
      () async {
    final repository = InMemoryRepository();
    final weeklyPracticeSchedule =
        await repository.createWeeklyPracticeSchedule(
            startRecurrence: DateTime(2023, 1, 1),
            practiceDuration: const Duration(hours: 1),
            practiceSessionsPerWeek: 5);
    final weeklyPracticeScheduleFromStorage =
        await repository.readWeeklyPracticeSchedule(weeklyPracticeSchedule.id);
    expect(weeklyPracticeSchedule, weeklyPracticeScheduleFromStorage);
  });

  test('createWeeklyPracticeSchedule gives schedules unique IDs', () async {
    final repository = InMemoryRepository();
    final weeklyPracticeSchedule1 =
        await repository.createWeeklyPracticeSchedule(
            startRecurrence: DateTime(2023, 1, 1),
            practiceDuration: const Duration(hours: 1),
            practiceSessionsPerWeek: 5);
    final weeklyPracticeSchedule2 =
        await repository.createWeeklyPracticeSchedule(
            startRecurrence: DateTime(2023, 2, 1),
            practiceDuration: const Duration(hours: 2),
            practiceSessionsPerWeek: 3);
    expect({weeklyPracticeSchedule1.id, weeklyPracticeSchedule2.id}.length, 2);
  });

  test('readWeeklyPracticeSchedule returns schedule with corresponding ID',
      () async {
    final repository = InMemoryRepository();
    final weeklyPracticeSchedule1 =
        await repository.createWeeklyPracticeSchedule(
            startRecurrence: DateTime(2023, 1, 1),
            practiceDuration: const Duration(hours: 1),
            practiceSessionsPerWeek: 5);
    final weeklyPracticeSchedule2 =
        await repository.createWeeklyPracticeSchedule(
            startRecurrence: DateTime(2023, 2, 1),
            practiceDuration: const Duration(hours: 2),
            practiceSessionsPerWeek: 3);
    final weeklyPracticeSchedule1FromStorage =
        await repository.readWeeklyPracticeSchedule(weeklyPracticeSchedule1.id);
    expect(weeklyPracticeSchedule1, weeklyPracticeSchedule1FromStorage);
    final weeklyPracticeSchedule2FromStorage =
        await repository.readWeeklyPracticeSchedule(weeklyPracticeSchedule2.id);
    expect(weeklyPracticeSchedule2, weeklyPracticeSchedule2FromStorage);
  });

  test(
      'readWeeklyPracticeSchedule throws an error if the schedule does not exist',
      () async {
    final repository = InMemoryRepository();
    final weeklyPracticeSchedule =
        await repository.createWeeklyPracticeSchedule(
            startRecurrence: DateTime(2023, 1, 1),
            practiceDuration: const Duration(hours: 1),
            practiceSessionsPerWeek: 5);
    expect(
        () async => await repository
            .readWeeklyPracticeSchedule(weeklyPracticeSchedule.id + 1),
        throwsArgumentError);
  });

  test('readWeeklyPracticeSchedules returns schedules with corresponding IDs',
      () async {
    final repository = InMemoryRepository();
    final weeklyPracticeSchedule1 =
        await repository.createWeeklyPracticeSchedule(
            startRecurrence: DateTime(2023, 1, 1),
            practiceDuration: const Duration(hours: 1),
            practiceSessionsPerWeek: 5);
    final weeklyPracticeSchedule2 =
        await repository.createWeeklyPracticeSchedule(
            startRecurrence: DateTime(2023, 2, 1),
            practiceDuration: const Duration(hours: 2),
            practiceSessionsPerWeek: 3);
    final weeklyPracticeSchedule3 =
        await repository.createWeeklyPracticeSchedule(
            startRecurrence: DateTime(2023, 3, 1),
            practiceDuration: const Duration(hours: 3),
            practiceSessionsPerWeek: 1);
    final schedulesFromStorage = await repository.readWeeklyPracticeSchedules([
      weeklyPracticeSchedule1.id,
      weeklyPracticeSchedule2.id,
      weeklyPracticeSchedule3.id
    ]);
    expect(schedulesFromStorage, [
      weeklyPracticeSchedule1,
      weeklyPracticeSchedule2,
      weeklyPracticeSchedule3
    ]);
  });

  test('readWeeklyPracticeSchedules returns schedules in specified order',
      () async {
    final repository = InMemoryRepository();
    final _ = await repository.createWeeklyPracticeSchedule(
        startRecurrence: DateTime(2023, 1, 1),
        practiceDuration: const Duration(hours: 1),
        practiceSessionsPerWeek: 5);
    final weeklyPracticeSchedule2 =
        await repository.createWeeklyPracticeSchedule(
            startRecurrence: DateTime(2023, 2, 1),
            practiceDuration: const Duration(hours: 2),
            practiceSessionsPerWeek: 3);
    final weeklyPracticeSchedule3 =
        await repository.createWeeklyPracticeSchedule(
            startRecurrence: DateTime(2023, 3, 1),
            practiceDuration: const Duration(hours: 3),
            practiceSessionsPerWeek: 1);
    final schedulesFromStorage = await repository.readWeeklyPracticeSchedules(
        [weeklyPracticeSchedule3.id, weeklyPracticeSchedule2.id]);
    expect(schedulesFromStorage,
        [weeklyPracticeSchedule3, weeklyPracticeSchedule2]);
  });

  test(
      'readWeeklyPracticeSchedules throws an error if a schedule does not exist',
      () async {
    final repository = InMemoryRepository();
    final weeklyPracticeSchedule1 =
        await repository.createWeeklyPracticeSchedule(
            startRecurrence: DateTime(2023, 1, 1),
            practiceDuration: const Duration(hours: 1),
            practiceSessionsPerWeek: 5);
    expect(
        () async => await repository.readWeeklyPracticeSchedules(
            [weeklyPracticeSchedule1.id, weeklyPracticeSchedule1.id + 1]),
        throwsArgumentError);
  });

  test('updateWeeklyPracticeSchedule returns updated schedule', () async {
    final repository = InMemoryRepository();
    final weeklyPracticeSchedule =
        await repository.createWeeklyPracticeSchedule(
            startRecurrence: DateTime(2023, 1, 1),
            practiceDuration: const Duration(hours: 1),
            practiceSessionsPerWeek: 5);
    final weeklyPracticeScheduleUpdate = WeeklyPracticeSchedule(
        id: weeklyPracticeSchedule.id,
        startRecurrence: weeklyPracticeSchedule.startRecurrence,
        practiceDuration: const Duration(hours: 2),
        practiceSessionsPerWeek:
            weeklyPracticeSchedule.practiceSessionsPerWeek);
    final returnValue = await repository
        .updateWeeklyPracticeSchedule(weeklyPracticeScheduleUpdate);
    expect(returnValue, weeklyPracticeScheduleUpdate);
  });

  test('updateWeeklyPracticeSchedule changes schedule data', () async {
    final repository = InMemoryRepository();
    final weeklyPracticeSchedule =
        await repository.createWeeklyPracticeSchedule(
            startRecurrence: DateTime(2023, 1, 1),
            practiceDuration: const Duration(hours: 1),
            practiceSessionsPerWeek: 5);
    final weeklyPracticeScheduleUpdate = WeeklyPracticeSchedule(
        id: weeklyPracticeSchedule.id,
        startRecurrence: weeklyPracticeSchedule.startRecurrence,
        practiceDuration: const Duration(hours: 2),
        practiceSessionsPerWeek:
            weeklyPracticeSchedule.practiceSessionsPerWeek);
    await repository.updateWeeklyPracticeSchedule(weeklyPracticeScheduleUpdate);
    final weeklyPracticeScheduleFromStorage =
        await repository.readWeeklyPracticeSchedule(weeklyPracticeSchedule.id);
    expect(weeklyPracticeScheduleFromStorage.practiceDuration,
        weeklyPracticeScheduleUpdate.practiceDuration);
  });

  test(
      'updateWeeklyPracticeSchedule throws an error if the schedule does not exist',
      () async {
    final repository = InMemoryRepository();
    final weeklyPracticeSchedule =
        await repository.createWeeklyPracticeSchedule(
            startRecurrence: DateTime(2023, 1, 1),
            practiceDuration: const Duration(hours: 1),
            practiceSessionsPerWeek: 5);
    final weeklyPracticeScheduleUpdate = WeeklyPracticeSchedule(
        id: weeklyPracticeSchedule.id + 1,
        startRecurrence: weeklyPracticeSchedule.startRecurrence,
        practiceDuration: const Duration(hours: 2),
        practiceSessionsPerWeek:
            weeklyPracticeSchedule.practiceSessionsPerWeek);
    expect(
        () async => await repository
            .updateWeeklyPracticeSchedule(weeklyPracticeScheduleUpdate),
        throwsArgumentError);
  });

  test('deleteWeeklyPracticeSchedule removes schedule from repository',
      () async {
    final repository = InMemoryRepository();
    final weeklyPracticeSchedule =
        await repository.createWeeklyPracticeSchedule(
            startRecurrence: DateTime(2023, 1, 1),
            practiceDuration: const Duration(hours: 1),
            practiceSessionsPerWeek: 5);
    await repository.deleteWeeklyPracticeSchedule(weeklyPracticeSchedule.id);
    expect(
        () async => await repository
            .readWeeklyPracticeSchedule(weeklyPracticeSchedule.id),
        throwsArgumentError);
  });

  test('deleteSkill throws an error if the skill does not exist', () async {
    final repository = InMemoryRepository();
    final weeklyPracticeSchedule =
        await repository.createWeeklyPracticeSchedule(
            startRecurrence: DateTime(2023, 1, 1),
            practiceDuration: const Duration(hours: 1),
            practiceSessionsPerWeek: 5);
    await repository.deleteWeeklyPracticeSchedule(weeklyPracticeSchedule.id);
    expect(
        () async => await repository
            .deleteWeeklyPracticeSchedule(weeklyPracticeSchedule.id),
        throwsArgumentError);
  });
}
