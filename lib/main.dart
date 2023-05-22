/// Runs the app.

import 'package:flutter/material.dart';

void main() {
  runApp(const RenaissanceManApp());
}

class RenaissanceManApp extends StatelessWidget {
  static const titleText = 'Renaissance Man';

  const RenaissanceManApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Renaissance Man',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.indigo, foregroundColor: Colors.white),
        ),
        home: Scaffold(
            appBar: AppBar(title: const Text(titleText)),
            body: const Column()));
  }
}
