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
  static List<Skill> skills = [
    Skill(
        id: 0, name: 'Piano', displayOrder: 0, createdAt: DateTime(2023, 1, 1)),
    Skill(
        id: 1,
        name: 'Russian',
        displayOrder: 1,
        createdAt: DateTime(2023, 1, 2)),
    Skill(
        id: 2,
        name: 'Cooking',
        displayOrder: 2,
        createdAt: DateTime(2023, 1, 3)),
    Skill(
        id: 3,
        name: 'Coding',
        displayOrder: 3,
        createdAt: DateTime(2023, 1, 4)),
    Skill(
        id: 4,
        name: 'Weight lifting',
        displayOrder: 4,
        createdAt: DateTime(2023, 1, 5))
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
