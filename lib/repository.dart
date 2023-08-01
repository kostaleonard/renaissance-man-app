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

  /// Returns a [List] of [WeeklyPracticeSchedule]s from backend storage.
  ///
  /// Returns a [List] of [WeeklyPracticeSchedule]s whose IDs match the ones
  /// given, and in the same order. If, for any ID in [ids], there is no
  /// [WeeklyPracticeSchedule] with matching ID, throws an [ArgumentError].
  Future<List<WeeklyPracticeSchedule>> readWeeklyPracticeSchedules(
      List<int> ids);

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

  //TODO authenticate with Firebase: https://pub.dev/packages/firebase_auth
  /// Returns a token that provides access to a specific user's data.
  /// TODO how this works:
  /// The user submits an email address and password to authenticate. The app
  /// sends the email and password to the API server, which calculates the
  /// salted hash of the password and compares it to the salted, hashed password
  /// it has stored. If they match, the API server generates a session token
  /// that is valid for the next, say, 15 minutes. The API server stores the
  /// session token and the user with whom it is associated in the database so
  /// that the API server is stateless. The API server sends the session token
  /// back to the user. The user includes the session token in all future
  /// requests. Every time it receives a valid request, the API server extends
  /// the lifetime of the session token.
  Future<String?> getAuthenticatedSessionToken(String emailAddress, String password);
}
