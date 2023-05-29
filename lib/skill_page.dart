/// Displays the user's tracked skills.

import 'package:flutter/cupertino.dart';
import 'package:renaissance_man/skill_repository.dart';

class SkillPage extends StatefulWidget {
  final SkillRepository skillRepository;

  SkillPage({Key? key, required this.skillRepository}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SkillPageState();
}

class _SkillPageState extends State<SkillPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
