/// Displays the user's tracked skills.

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:renaissance_man/skill.dart';
import 'package:renaissance_man/skill_preview_card.dart';
import 'package:renaissance_man/skill_repository.dart';

class SkillSelectPage extends StatefulWidget {
  final SkillRepository skillRepository;

  const SkillSelectPage({Key? key, required this.skillRepository})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SkillSelectPageState();
}

class _SkillSelectPageState extends State<SkillSelectPage> {
  static const _biggerFont = TextStyle(fontSize: 18);
  static const _gridViewMaxCrossAxisExtent = 200.0;
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
                  final skillPreviewCards = skillsToDisplay
                      .map((skill) => SkillPreviewCard(skill: skill))
                      .toList(growable: false);
                  //TODO make this button more muted so that it doesn't stand out
                  final addSkillButton = CupertinoButton.filled(
                      onPressed: () {
                        setState(() {
                          widget.skillRepository.createSkill(
                              'New skill'); //TODO user should choose name
                          skillQuery = widget.skillRepository.readSkills();
                        });
                      },
                      child: const Icon(Icons.add));
                  return Expanded(
                      child: LayoutBuilder(builder: (context, constraints) {
                    //TODO update magic numbers to static constants
                    //See Flutter's SliverGridDelegateWithMaxCrossAxisExtent for an explanation of this calculation.
                    final numGridViewColumns = max(
                        1,
                        ((constraints.biggest.width - 16) /
                                (_gridViewMaxCrossAxisExtent + 10))
                            .ceil());
                    final usableCrossAxisExtent = max(
                      0,
                      constraints.biggest.width -
                          16 -
                          10 * (numGridViewColumns - 1),
                    );
                    final gridViewColumnSize =
                        usableCrossAxisExtent / numGridViewColumns;
                    return Stack(children: [
                      GridView.extent(
                        padding: const EdgeInsets.all(8),
                        mainAxisSpacing: 25,
                        crossAxisSpacing: 10,
                        maxCrossAxisExtent: _gridViewMaxCrossAxisExtent,
                        children: <Widget>[addSkillButton] + skillPreviewCards,
                      ),
                      Positioned(
                          top: 8,
                          left: 8 + gridViewColumnSize,
                          child: Container(
                            width: 100,
                            height: 100,
                            color: Colors.red,
                            child: Text('$numGridViewColumns'),
                          ))
                    ]);
                  }));
                }
              },
            ),
          ],
        ));
  }
}
