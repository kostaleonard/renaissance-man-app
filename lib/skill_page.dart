/// Displays the user's tracked skills.

import 'package:flutter/material.dart';
import 'package:renaissance_man/skill.dart';
import 'package:renaissance_man/skill_preview_card.dart';
import 'package:renaissance_man/skill_repository.dart';

class SkillPage extends StatefulWidget {
  final SkillRepository skillRepository;

  const SkillPage({Key? key, required this.skillRepository}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SkillPageState();
}

class _SkillPageState extends State<SkillPage> {
  final List<Skill> skills = List.empty(growable: true);
  late Future<List<Skill>> skillQuery;

  @override
  void initState() {
    super.initState();
    // TODO remove test data
    widget.skillRepository.createSkill('Piano');
    widget.skillRepository.createSkill('Russian');
    widget.skillRepository.createSkill('Cooking');
    widget.skillRepository.createSkill('Weight lifting');
    skillQuery = widget.skillRepository.readSkills();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Renaissance Man')),
      body: ListView.builder(
          itemCount: skills.length * 2,
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, i) {
            if (i.isOdd) return const Divider();
            final index = i ~/ 2;
            return SkillPreviewCard(skill: skills[index]);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => (), // TODO add skill API call
        tooltip: 'Add skill',
        child: const Icon(Icons.add),
      ),
    );
  }
}
