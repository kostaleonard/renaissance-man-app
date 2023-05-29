/// Runs the app.

import 'package:flutter/material.dart';
import 'package:renaissance_man/skill.dart';
import 'package:renaissance_man/skill_preview_card.dart';

void main() {
  runApp(const RenaissanceManApp());
}

// TODO docstrings
class RenaissanceManApp extends StatelessWidget {
  static const appTitle = 'Renaissance Man';
  static const skills = [
    Skill(name: 'Piano'),
    Skill(name: 'Russian'),
    Skill(name: 'Cooking'),
    Skill(name: 'Coding'),
    Skill(name: 'Weight lifting')
  ]; // TODO this is test data

  const RenaissanceManApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: appTitle,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.blueGrey, foregroundColor: Colors.white),
        ),
        home: Scaffold(
          appBar: AppBar(title: const Text(appTitle)),
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
        ));
  }
}
