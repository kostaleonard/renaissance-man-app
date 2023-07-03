/// Contains the widget for skill preview cards on the home page.

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:renaissance_man/repository.dart';
import 'package:renaissance_man/skill.dart';
import 'package:renaissance_man/skill_page.dart';

//TODO when a user closes the skill page after making changes, do those changes reflect on the card here?
class SkillPreviewCard extends StatelessWidget {
  final Repository repository;
  final Skill skill;
  static const height = 298.0;

  const SkillPreviewCard({super.key, required this.repository, required this.skill});

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionDuration: const Duration(milliseconds: 350),
      transitionType: ContainerTransitionType.fade,
      closedBuilder: (context, openContainer) {
        return Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: openContainer,
            splashColor:
                Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
            highlightColor: Colors.transparent,
            child: Text(skill.name),
            //TODO also display number of hours
          ),
        );
      },
      openBuilder: (context, closeContainer) {
        return SkillPage(repository: repository, skillId: skill.id,);
      },
    );
  }
}
