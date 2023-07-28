/// Runs the app.

import 'package:flutter/material.dart';
import 'package:renaissance_man/routes.dart';
import 'package:renaissance_man/skill_select_page.dart';
import 'package:renaissance_man/repository.dart';
import 'package:renaissance_man/in_memory_repository.dart';

import 'login_page.dart';

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
        initialRoute: loginRoute,
        routes: {
          homeRoute: (context) => SkillSelectPage(repository: repository,),
          loginRoute: (context) => LoginPage()
        },
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.green,
              accentColor: const Color(0xff06fcbe),
            ),
            cardTheme: const CardTheme(
              color: Color(0xffc7ffbc),
              margin: EdgeInsets.zero,
            )),
        );
  }
}
