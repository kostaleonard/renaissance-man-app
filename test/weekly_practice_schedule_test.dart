/// Tests weekly_practice_schedule.dart.

import 'package:flutter_test/flutter_test.dart';
import 'package:renaissance_man/weekly_practice_schedule.dart';

void main() {
  test(
      'getTimePracticedBetween returns practice duration times number of sessions per week when window is one week',
      () async {
    final weeklyPracticeSchedule = WeeklyPracticeSchedule(
        id:1,
        startRecurrence: DateTime(2023, 1, 1),
        practiceDuration: const Duration(hours: 1),
        practiceSessionsPerWeek: 7);
    final timePracticed = weeklyPracticeSchedule.getTimePracticedBetween(
        DateTime(2023, 1, 1), DateTime(2023, 1, 8));
    expect(timePracticed, const Duration(hours: 7));
  });

  test(
      'getTimePracticedBetween returns only the duration after the start recurrence date when the start date comes earlier',
          () async {
        final weeklyPracticeSchedule = WeeklyPracticeSchedule(
            id:1,
            startRecurrence: DateTime(2023, 1, 2),
            practiceDuration: const Duration(hours: 1),
            practiceSessionsPerWeek: 7);
        final timePracticed = weeklyPracticeSchedule.getTimePracticedBetween(
            DateTime(2023, 1, 1), DateTime(2023, 1, 8));
        expect(timePracticed, const Duration(hours: 6));
      });

  test(
      'getTimePracticedBetween returns only the duration before the end recurrence date when the end date comes later',
          () async {
        final weeklyPracticeSchedule = WeeklyPracticeSchedule(
            id:1,
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
          () async {
        final weeklyPracticeSchedule = WeeklyPracticeSchedule(
            id:1,
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
          () async {
        final weeklyPracticeSchedule = WeeklyPracticeSchedule(
            id:1,
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
          () async {
        final weeklyPracticeSchedule = WeeklyPracticeSchedule(
            id:1,
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
}
