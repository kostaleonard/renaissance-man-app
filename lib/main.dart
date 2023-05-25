/// Runs the app.

import 'package:flutter/material.dart';

void main() {
  runApp(const RenaissanceManApp());
}

class RenaissanceManApp extends StatelessWidget {
  static const appTitle = 'Renaissance Man';
  static const skills = ['Piano', 'Russian', 'Cooking', 'Coding']; // TODO this is test data

  const RenaissanceManApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Renaissance Man',
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
                return ListTile(
                    leading: const Icon(Icons.bolt),
                    title: Text(skills[index]));
              }),
          floatingActionButton: FloatingActionButton(
            onPressed: () => (), // TODO add skill API call
            tooltip: 'Add skill',
            child: const Icon(Icons.add),
          ),
        ));
  }
}
