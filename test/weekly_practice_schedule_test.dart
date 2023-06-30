/// Tests weekly_practice_schedule.dart.

import 'package:flutter_test/flutter_test.dart';
import 'package:renaissance_man/weekly_practice_schedule.dart';

void main() {
  test(
      'getTimePracticedBetween returns practice duration times number of sessions per week when window is one week',
      () {
    final weeklyPracticeSchedule = WeeklyPracticeSchedule(
        id: 1,
        startRecurrence: DateTime(2023, 1, 1),
        practiceDuration: const Duration(hours: 1),
        practiceSessionsPerWeek: 7);
    final timePracticed = weeklyPracticeSchedule.getTimePracticedBetween(
        DateTime(2023, 1, 1), DateTime(2023, 1, 8));
    expect(timePracticed, const Duration(hours: 7));
  });

  test(
      'getTimePracticedBetween returns only the duration after the start recurrence date when the start date comes earlier',
      () {
    final weeklyPracticeSchedule = WeeklyPracticeSchedule(
        id: 1,
        startRecurrence: DateTime(2023, 1, 2),
        practiceDuration: const Duration(hours: 1),
        practiceSessionsPerWeek: 7);
    final timePracticed = weeklyPracticeSchedule.getTimePracticedBetween(
        DateTime(2023, 1, 1), DateTime(2023, 1, 8));
    expect(timePracticed, const Duration(hours: 6));
  });

  test(
      'getTimePracticedBetween returns only the duration before the end recurrence date when the end date comes later',
      () {
    final weeklyPracticeSchedule = WeeklyPracticeSchedule(
        id: 1,
        startRecurrence: DateTime(2023, 1, 1),
        endRecurrence: DateTime(2023, 1, 7),
        practiceDuration: const Duration(hours: 1),
        practiceSessionsPerWeek: 7);
    final timePracticed = weeklyPracticeSchedule.getTimePracticedBetween(
        DateTime(2023, 1, 1), DateTime(2023, 1, 8));
    expect(timePracticed, const Duration(hours: 6));
  });

  test(
      'getTimePracticedBetween returns only the duration between recurrence start and end dates when the start and end window is wider',
      () {
    final weeklyPracticeSchedule = WeeklyPracticeSchedule(
        id: 1,
        startRecurrence: DateTime(2023, 1, 2),
        endRecurrence: DateTime(2023, 1, 7),
        practiceDuration: const Duration(hours: 1),
        practiceSessionsPerWeek: 7);
    final timePracticed = weeklyPracticeSchedule.getTimePracticedBetween(
        DateTime(2023, 1, 1), DateTime(2023, 1, 8));
    expect(timePracticed, const Duration(hours: 5));
  });

  test(
      'getTimePracticedBetween returns zero duration when the start and end window does not coincide with the recurrence window',
      () {
    final weeklyPracticeSchedule = WeeklyPracticeSchedule(
        id: 1,
        startRecurrence: DateTime(2023, 1, 1),
        endRecurrence: DateTime(2023, 1, 8),
        practiceDuration: const Duration(hours: 1),
        practiceSessionsPerWeek: 7);
    final timePracticed = weeklyPracticeSchedule.getTimePracticedBetween(
        DateTime(2023, 2, 1), DateTime(2023, 2, 8));
    expect(timePracticed, Duration.zero);
  });

  test(
      'getTimePracticedBetween returns prorated practice duration when the start and end window is not a multiple of one week',
      () {
    final weeklyPracticeSchedule = WeeklyPracticeSchedule(
        id: 1,
        startRecurrence: DateTime(2023, 1, 1),
        practiceDuration: const Duration(hours: 1),
        practiceSessionsPerWeek: 7);
    var timePracticed = weeklyPracticeSchedule.getTimePracticedBetween(
        DateTime(2023, 1, 1), DateTime(2023, 1, 5));
    expect(timePracticed, const Duration(hours: 4));
    timePracticed = weeklyPracticeSchedule.getTimePracticedBetween(
        DateTime(2023, 1, 1), DateTime(2023, 1, 8, 12));
    expect(timePracticed, const Duration(hours: 7, minutes: 30));
  });

  test('WeeklyPracticeSchedule == operator compares IDs', () {
    final weeklyPracticeSchedule1 = WeeklyPracticeSchedule(id: 1, startRecurrence: DateTime(2023, 1, 1), practiceDuration: Duration.zero, practiceSessionsPerWeek: 0);
    final weeklyPracticeSchedule2 = WeeklyPracticeSchedule(id: 1, startRecurrence: DateTime(2023, 1, 1), practiceDuration: const Duration(hours: 1), practiceSessionsPerWeek: 5);
    expect(weeklyPracticeSchedule1 == weeklyPracticeSchedule2, isTrue);
  });

  test('WeeklyPracticeSchedule hashCode is equal for schedules with equal IDs', () {
    final weeklyPracticeSchedule1 = WeeklyPracticeSchedule(id: 1, startRecurrence: DateTime(2023, 1, 1), practiceDuration: Duration.zero, practiceSessionsPerWeek: 0);
    final weeklyPracticeSchedule2 = WeeklyPracticeSchedule(id: 1, startRecurrence: DateTime(2023, 1, 1), practiceDuration: const Duration(hours: 1), practiceSessionsPerWeek: 5);
    expect(weeklyPracticeSchedule1.hashCode, weeklyPracticeSchedule2.hashCode);
  });
}
