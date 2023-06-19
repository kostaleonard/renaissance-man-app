/// Runs the app.

import 'package:flutter/material.dart';
import 'package:renaissance_man/skill_select_page.dart';
import 'package:renaissance_man/skill_repository.dart';

import 'in_memory_skill_repository.dart';

void main() {
  //TODO remove delay--it's only for seeing how UI components render
  runApp(RenaissanceManApp(
      skillRepository: InMemorySkillRepository(withDelay: Duration.zero)));
}

// TODO docstrings
class RenaissanceManApp extends StatelessWidget {
  static const appTitle = 'Renaissance Man';
  final SkillRepository skillRepository;

  const RenaissanceManApp({super.key, required this.skillRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: appTitle,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.blueGrey, foregroundColor: Colors.white),
        ),
        home: SkillSelectPage(
          skillRepository: skillRepository,
        ));
  }
}
