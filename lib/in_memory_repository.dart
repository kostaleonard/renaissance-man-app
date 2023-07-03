//TODO docstrings

import 'package:renaissance_man/skill.dart';
import 'package:renaissance_man/repository.dart';
import 'package:renaissance_man/weekly_practice_schedule.dart';

class InMemoryRepository extends Repository {
  final _skills = <Skill>[]; // TODO would like data structure with O(1) prepend
  var _nextAvailableSkillId = 0;
  final _weeklyPracticeSchedules = <WeeklyPracticeSchedule>{};
  var _nextAvailableWeeklyPracticeId = 0;
  final Duration withDelay;

  InMemoryRepository({this.withDelay = Duration.zero});

  @override
  Future<Skill> createSkill(String name) {
    final skill = Skill(id: _nextAvailableSkillId, name: name);
    _nextAvailableSkillId++;
    _skills.insert(0, skill);
    return Future.delayed(withDelay, () => skill);
  }

  @override
  Future<Skill> readSkill(int id) {
    final skill = _skills.firstWhere((skill) => skill.id == id, orElse: () {
      throw ArgumentError('The repository does not contain skill $id');
    });
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
  Future<Skill> updateSkill(Skill skill) {
    final index = _skills.indexOf(skill);
    if (index == -1) {
      throw ArgumentError('The repository does not contain skill ${skill.id}');
    }
    _skills.removeAt(index);
    _skills.insert(index, skill);
    return Future.delayed(withDelay, () => skill);
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

  @override
  Future<WeeklyPracticeSchedule> createWeeklyPracticeSchedule(
      {required DateTime startRecurrence,
      DateTime? endRecurrence,
      required Duration practiceDuration,
      required int practiceSessionsPerWeek}) {
    final weeklyPracticeSchedule = WeeklyPracticeSchedule(
        id: _nextAvailableWeeklyPracticeId,
        startRecurrence: startRecurrence,
        endRecurrence: endRecurrence,
        practiceDuration: practiceDuration,
        practiceSessionsPerWeek: practiceSessionsPerWeek);
    _nextAvailableWeeklyPracticeId++;
    _weeklyPracticeSchedules.add(weeklyPracticeSchedule);
    return Future.delayed(withDelay, () => weeklyPracticeSchedule);
  }

  @override
  Future<WeeklyPracticeSchedule> readWeeklyPracticeSchedule(int id) {
    final weeklyPracticeSchedule = _weeklyPracticeSchedules
        .firstWhere((schedule) => schedule.id == id, orElse: () {
      throw ArgumentError(
          'The repository does not contain weekly practice schedule $id');
    });
    return Future.delayed(withDelay, () => weeklyPracticeSchedule);
  }

  @override
  Future<WeeklyPracticeSchedule> updateWeeklyPracticeSchedule(
      WeeklyPracticeSchedule weeklyPracticeSchedule) {
    deleteWeeklyPracticeSchedule(weeklyPracticeSchedule.id);
    _weeklyPracticeSchedules.add(weeklyPracticeSchedule);
    return Future.delayed(withDelay, () => weeklyPracticeSchedule);
  }

  @override
  Future<void> deleteWeeklyPracticeSchedule(int id) {
    final lengthBeforeRemove = _weeklyPracticeSchedules.length;
    _weeklyPracticeSchedules.removeWhere((schedule) => schedule.id == id);
    if (_weeklyPracticeSchedules.length == lengthBeforeRemove) {
      throw ArgumentError(
          'The repository does not contain weekly practice schedule $id');
    }
    return Future.delayed(withDelay, () => null);
  }
}
