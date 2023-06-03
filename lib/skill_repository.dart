/// Provides an interface with storage media for skill data.

import 'package:renaissance_man/skill.dart';
import 'package:renaissance_man/skill_candidate.dart';

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
  /// Uses the information in [skillCandidate] to create a full-fledged [Skill]
  /// in backend storage. If an equivalent [Skill] already exists, throws TODO do we actually want to throw an error?
  Future<Skill> createSkill(SkillCandidate skillCandidate);

  /// Returns a list of [Skill]s from backend storage.
  ///
  /// Returns the first [limit] or fewer [Skill]s from backend storage, skipping
  /// the first [skip] elements, where [Skill]s are sorted chronologically by
  /// creation time.
  Future<List<Skill>> readSkills(int limit, {int skip = 0});

  /// Updates a [Skill] in backend storage and returns it on success.
  ///
  /// Updates the [Skill] in backend storage with the same name as
  /// [skillCandidate]. If no such [Skill] exists, throws TODO which error?
  Future<Skill> updateSkill(SkillCandidate skillCandidate);

  /// Deletes a [Skill] from backend storage.
  ///
  /// If no such [Skill] exists, throws TODO which error?
  Future<void> deleteSkill(Skill skill);
}
