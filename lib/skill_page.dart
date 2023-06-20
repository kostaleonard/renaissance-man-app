/// Displays an in-depth view of a single skill.

import 'package:flutter/material.dart';
import 'package:renaissance_man/skill.dart';

class SkillPage extends StatelessWidget {
  final Skill skill;

  const SkillPage({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(skill.name)), body: const Column());
  }
}
