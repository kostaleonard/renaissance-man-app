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
  static const _gridViewPadding = 8.0;
  static const _gridViewMainAxisSpacing = 25.0;
  static const _gridViewCrossAxisSpacing = 10.0;
  static const _gridViewMaxCrossAxisExtent = 300.0;
  late TextEditingController _textEditingController;
  late FocusNode _textFieldFocusNode;
  bool _showCreateSkillWindow = false;
  late Future<List<Skill>> skillQuery;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: '');
    _textFieldFocusNode = FocusNode();
    // TODO remove test data
    widget.skillRepository.createSkill('Piano');
    widget.skillRepository.createSkill('Russian');
    widget.skillRepository.createSkill('Cooking');
    widget.skillRepository.createSkill('Weight lifting');
    skillQuery = widget.skillRepository.readSkills();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _textFieldFocusNode.dispose();
    super.dispose();
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
                          _showCreateSkillWindow = !_showCreateSkillWindow;
                        });
                      },
                      child: const Icon(Icons.add));
                  final skillGridView = GridView.extent(
                    padding: const EdgeInsets.all(_gridViewPadding),
                    mainAxisSpacing: _gridViewMainAxisSpacing,
                    crossAxisSpacing: _gridViewCrossAxisSpacing,
                    maxCrossAxisExtent: _gridViewMaxCrossAxisExtent,
                    childAspectRatio: 1 / .4,
                    children: <Widget>[addSkillButton] + skillPreviewCards,
                  );
                  if (!_showCreateSkillWindow) {
                    return Expanded(child: skillGridView);
                  }
                  return Expanded(
                      child: LayoutBuilder(builder: (context, constraints) {
                    // See Flutter's SliverGridDelegateWithMaxCrossAxisExtent for an explanation of these calculations.
                    final numGridViewColumns = max(
                        1,
                        ((constraints.biggest.width - 2 * _gridViewPadding) /
                                (_gridViewMaxCrossAxisExtent +
                                    _gridViewCrossAxisSpacing))
                            .ceil());
                    final usableCrossAxisExtent = max(
                      0,
                      constraints.biggest.width -
                          2 * _gridViewPadding -
                          _gridViewCrossAxisSpacing * (numGridViewColumns - 1),
                    );
                    final gridViewColumnSize =
                        usableCrossAxisExtent / numGridViewColumns;
                    return Stack(children: [
                      skillGridView,
                      Positioned(
                          top: _gridViewPadding,
                          left: _gridViewPadding +
                              _gridViewCrossAxisSpacing +
                              gridViewColumnSize,
                          child: Container(
                              width: 300,
                              color: Colors.grey,
                              child: Column(children: [
                                const Text('Create new skill'),
                                const Divider(),
                                Row(children: [
                                  Expanded(
                                      child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: TextField(
                                            controller: _textEditingController,
                                            focusNode: _textFieldFocusNode,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Skill name'),
                                            onSubmitted: (text) {
                                              if (text.trim().isNotEmpty) {
                                                submitCreateSkillTextField(
                                                    text);
                                                _textEditingController.clear();
                                                setState(() {
                                                  _showCreateSkillWindow =
                                                      false;
                                                });
                                              } else {
                                                _textFieldFocusNode
                                                    .requestFocus();
                                              }
                                            },
                                          ))),
                                  Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: FloatingActionButton(
                                        //TODO can we make this button square and more muted?
                                        child: const Icon(Icons.send),
                                        onPressed: () {
                                          if (_textEditingController.text
                                              .trim()
                                              .isNotEmpty) {
                                            submitCreateSkillTextField(
                                                _textEditingController.text);
                                            _textEditingController.clear();
                                            setState(() {
                                              _showCreateSkillWindow = false;
                                            });
                                          } else {
                                            _textFieldFocusNode.requestFocus();
                                          }
                                        },
                                      ))
                                ])
                              ])))
                    ]);
                  }));
                }
              },
            ),
          ],
        ));
  }

  void submitCreateSkillTextField(String text) {
    final trimmedText = text.trim();
    if (trimmedText.isEmpty) return;
    widget.skillRepository.createSkill(trimmedText).then((_) => setState(() {
          skillQuery = widget.skillRepository.readSkills();
        }));
  }
}
