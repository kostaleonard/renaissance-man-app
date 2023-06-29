/// Displays an in-depth view of a single skill.

import 'package:flutter/material.dart';
import 'package:renaissance_man/skill.dart';

class SkillPage extends StatelessWidget {
  final Skill skill;

  const SkillPage({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    //TODO add a large graph showing cumulative progress (like in an investment portfolio)
    //TODO add widgets for adding/removing cron-job like scheduled practice sessions
    return Scaffold(
        appBar: AppBar(title: Text(skill.name)), body: const Column());
  }
}
