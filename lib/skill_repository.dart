/// Implements create, read, update, and delete methods for tracked skills.

import 'package:renaissance_man/skill.dart';
import 'package:renaissance_man/skill_candidate.dart';

abstract class SkillRepository {
  /// Creates a [Skill] in backend storage and returns it on success.
  ///
  /// Uses the information in [skillCandidate] to create a full-fledged [Skill]
  /// in backend storage. If backend storage is a database, this method might
  /// execute a SQL request directly on the database, or it might execute an
  /// HTTP request on a database proxy server or API server. If backend storage
  /// is in memory (say, for testing), this method might simply interface with
  /// that memory directly. If an equivalent [Skill] already exists, throws TODO do we actually want to throw an error?
  /// TODO move this part of the docstring to the class level because it applies to all methods
  /// TODO rest of docstrings
  Future<Skill> createSkill(SkillCandidate skillCandidate);

  Future<List<Skill>> readSkills(int limit);

  Future<Skill> updateSkill(SkillCandidate skillCandidate);

  Future<void> deleteSkill(Skill skill);
}
