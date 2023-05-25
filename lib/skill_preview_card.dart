/// Contains the widget for skill preview cards on the home page.

import 'package:flutter/material.dart';
import 'package:renaissance_man/skill.dart';

class SkillPreviewCard extends StatelessWidget {
  final Skill skill;

  const SkillPreviewCard({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    return ListTile(leading: const Icon(Icons.bolt), title: Text(skill.name));
  }
}
