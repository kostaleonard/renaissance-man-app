/// Tests skill.dart.

import 'package:flutter_test/flutter_test.dart';
import 'package:renaissance_man/skill.dart';

void main() {
  test('Skill toString returns the name', () {
    final skill = Skill(id: 1, name: 'Piano');
    expect(skill.toString(), skill.name);
  });

  test('Skill == operator compares IDs', () {
    final skill1 = Skill(id: 1, name: 'Piano');
    final skill2 = Skill(id: 1, name: 'Russian');
    expect(skill1 == skill2, isTrue);
  });

  test('Skill hashCode is equal for skills with equal IDs', () {
    final skill1 = Skill(id: 1, name: 'Piano');
    final skill2 = Skill(id: 1, name: 'Russian');
    expect(skill1.hashCode, skill2.hashCode);
  });
}
