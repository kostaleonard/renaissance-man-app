/// Provides an interface with storage media for app data.

import 'package:renaissance_man/skill.dart';
import 'package:renaissance_man/weekly_practice_schedule.dart';

/// Implements create, read, update, and delete methods for app data.
///
/// This class does not enforce the use of any particular storage medium.
/// Subclasses need to make this decision. Some choices of storage media include
/// a database, disk storage, and in-memory storage. Subclasses need to
/// implement create, read, update, and delete methods consistent with their
/// choice of storage medium: for databases, SQL queries (or HTTP requests on a
/// proxy); for disk, file I/O; for in-memory, changing entries in a data
/// structure.
abstract class Repository {
  /// Creates a [Skill] in backend storage and returns it on success.
  ///
  /// Creates a [Skill] with name [name] in backend storage. Multiple [Skill]s
  /// may have the same name.
  Future<Skill> createSkill(String name);

  /// Returns the [Skill] with ID [id] from backend storage.
  ///
  /// If there is no [Skill] with ID [id], throws an [ArgumentError].
  Future<Skill> readSkill(int id);

  /// Returns a list of [Skill]s from backend storage.
  ///
  /// Returns the first [limit] or fewer [Skill]s from backend storage, skipping
  /// the first [skip] elements, where [Skill]s are sorted chronologically by
  /// creation time. If [limit] is not specified, returns all [Skill]s.
  Future<List<Skill>> readSkills({int? limit, int skip = 0});

  /// Updates a [Skill] in backend storage and returns the new value on success.
  ///
  /// Updates in backend storage the [Skill] with ID [skill.id] to have all
  /// the new information contained in [skill]. If there is no [Skill] with ID
  /// [skill.id], throws an [ArgumentError].
  Future<Skill> updateSkill(Skill skill);

  /// Deletes a [Skill] from backend storage.
  ///
  /// If there is no [Skill] with ID [id], throws an [ArgumentError].
  Future<void> deleteSkill(int id);

  /// Creates a [WeeklyPracticeSchedule] in backend storage and returns it.
  Future<WeeklyPracticeSchedule> createWeeklyPracticeSchedule(
      {required DateTime startRecurrence,
      DateTime? endRecurrence,
      required Duration practiceDuration,
      required int practiceSessionsPerWeek});

  /// Returns a [WeeklyPracticeSchedule] from backend storage.
  ///
  /// If there is no [WeeklyPracticeSchedule] with ID [id], throws an
  /// [ArgumentError].
  Future<WeeklyPracticeSchedule> readWeeklyPracticeSchedule(int id);

  /// Updates a [WeeklyPracticeSchedule] in backend storage and returns it.
  ///
  /// Updates in backend storage the [WeeklyPracticeSchedule] with ID
  /// [weeklyPracticeSchedule.id] to have all the new information contained in
  /// [weeklyPracticeSchedule]. If there is no [WeeklyPracticeSchedule] with ID
  /// [weeklyPracticeSchedule.id], throws an [ArgumentError].
  Future<WeeklyPracticeSchedule> updateWeeklyPracticeSchedule(
      WeeklyPracticeSchedule weeklyPracticeSchedule);

  /// Deletes a [WeeklyPracticeSchedule] from backend storage.
  ///
  /// If there is no [WeeklyPracticeSchedule] with ID [id], throws an
  /// [ArgumentError].
  Future<void> deleteWeeklyPracticeSchedule(int id);
}
