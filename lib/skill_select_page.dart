/// Displays the user's tracked skills.

import 'package:flutter/material.dart';
import 'package:renaissance_man/skill.dart';
import 'package:renaissance_man/skill_preview_card.dart';
import 'package:renaissance_man/skill_repository.dart';

class SkillSelectPage extends StatefulWidget {
  final SkillRepository skillRepository;

  const SkillSelectPage({Key? key, required this.skillRepository}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SkillSelectPageState();
}

class _SkillSelectPageState extends State<SkillSelectPage> {
  static const _biggerFont = TextStyle(fontSize: 18);
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
        body: Column(
          children: [
            //TODO button?
            FutureBuilder(
              future: skillQuery,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(
                      child: Text('No connection', style: _biggerFont));
                } else {
                  final skillsToDisplay = snapshot.data ?? [];
                  return Expanded(
                      child: ListView.builder(
                          itemCount: skillsToDisplay.length * 2,
                          padding: const EdgeInsets.all(8),
                          itemBuilder: (context, i) {
                            if (i.isOdd) return const Divider();
                            final index = i ~/ 2;
                            return SkillPreviewCard(
                                skill: skillsToDisplay[index]);
                          }));
                }
              },
            ),
          ],
        ));
  }
}
