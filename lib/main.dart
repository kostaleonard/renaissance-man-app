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
              accentColor: const Color(0xff06fcbe),
          ),
          cardTheme: const CardTheme(
            color: Color(0xffadff9f)
          )
        ),
        home: SkillSelectPage(
          repository: repository,
        ));
  }
}
