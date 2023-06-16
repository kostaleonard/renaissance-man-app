/// Provides an interface with storage media for skill data.

import 'package:renaissance_man/skill.dart';

/// Implements create, read, update, and delete methods for tracked skills.
///
/// This class does not enforce the use of any particular storage medium.
/// Subclasses need to make this decision. Some choices of storage media include
/// a database, disk storage, and in-memory storage. Subclasses need to
/// implement create, read, update, and delete methods consistent with their
/// choice of storage medium: for databases, SQL queries (or HTTP requests on a
/// proxy); for disk, file I/O; for in-memory, changing entries in a data
/// structure.
abstract class SkillRepository {
  /// Creates a [Skill] in backend storage and returns it on success.
  ///
  /// Creates a [Skill] with name [name] in backend storage. Multiple [Skill]s
  /// may have the same name.
  Future<Skill> createSkill(String name);

  /// Returns a list of [Skill]s from backend storage.
  ///
  /// Returns the first [limit] or fewer [Skill]s from backend storage, skipping
  /// the first [skip] elements, where [Skill]s are sorted chronologically by
  /// creation time. If [limit] is not specified, returns all [Skill]s.
  Future<List<Skill>> readSkills({int? limit, int skip = 0});

  /// Updates a [Skill] in backend storage and returns the new value on success.
  ///
  /// If there is no [Skill] with ID [id], throws an [ArgumentError].
  /// TODO what are the arguments for the new values? Get the current skill's JSON representation, update it, and create a new Skill from it?
  Future<Skill> updateSkill(int id);

  /// Deletes a [Skill] from backend storage.
  ///
  /// If there is no [Skill] with ID [id], throws an [ArgumentError].
  Future<void> deleteSkill(int id);
}
