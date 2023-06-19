/// Contains the widget for skill preview cards on the home page.

import 'package:flutter/material.dart';
import 'package:renaissance_man/skill.dart';

class SkillPreviewCard extends StatelessWidget {
  final Skill skill;
  static const height = 298.0;

  const SkillPreviewCard({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          // TODO go to skill page
        },
        splashColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
        highlightColor: Colors.transparent,
        child: Text(skill.name),
        //TODO also display number of hours
      ),
    );
  }
}
