/// Runs the app.

import 'package:flutter/material.dart';
import 'package:renaissance_man/skill_select_page.dart';
import 'package:renaissance_man/repository.dart';
import 'package:renaissance_man/in_memory_repository.dart';

void main() {
  //TODO remove delay--it's only for seeing how UI components render
  runApp(RenaissanceManApp(
      repository: InMemoryRepository(withDelay: Duration.zero)));
}

// TODO docstrings
class RenaissanceManApp extends StatelessWidget {
  static const appTitle = 'Renaissance Man';
  final Repository repository;

  const RenaissanceManApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: appTitle,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.blueGrey, foregroundColor: Colors.white),
        ),
        home: SkillSelectPage(
          repository: repository,
        ));
  }
}
