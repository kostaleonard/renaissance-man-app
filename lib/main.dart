/// Runs the app.

import 'package:flutter/material.dart';
import 'package:renaissance_man/skill_select_page.dart';
import 'package:renaissance_man/repository.dart';
import 'package:renaissance_man/in_memory_repository.dart';

void main() {
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
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.green,
              backgroundColor: const Color(0xffcfcecf)),
        ),
        home: SkillSelectPage(
          repository: repository,
        ));
  }
}
