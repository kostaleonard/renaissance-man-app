/// Displays an in-depth view of a single skill.

import 'package:flutter/material.dart';
import 'package:renaissance_man/repository.dart';
import 'package:renaissance_man/skill.dart';

class SkillPage extends StatefulWidget {
  final Repository repository;
  final int skillId;

  const SkillPage({Key? key, required this.repository, required this.skillId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SkillPageState();
}

class _SkillPageState extends State<SkillPage> {
  static const _biggerFont = TextStyle(fontSize: 18);
  late Future<Skill> skillQuery;
  //TODO get all the practice schedules associated with the skill

  @override
  void initState() {
    super.initState();
    skillQuery = widget.repository.readSkill(widget.skillId);
  }

  @override
  Widget build(BuildContext context) {
    //TODO add a large graph showing cumulative progress (like in an investment portfolio)
    //TODO add widgets for adding/removing scheduled practice sessions
    return FutureBuilder(
      future: skillQuery,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('No connection', style: _biggerFont));
        } else {
          final skill = snapshot.data!;
          return Scaffold(
              appBar: AppBar(title: Text(skill.name)), body: const Column());
        }
      },
    );
  }
}
