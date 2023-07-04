/// Displays an in-depth view of a single skill.

import 'package:flutter/material.dart';
import 'package:renaissance_man/repository.dart';
import 'package:renaissance_man/skill.dart';
import 'package:renaissance_man/weekly_practice_schedule_list_item.dart';

class SkillPage extends StatefulWidget {
  final Repository repository;
  final int skillId;

  const SkillPage({Key? key, required this.repository, required this.skillId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SkillPageState();
}

class _SkillPageState extends State<SkillPage> {
  static const _biggerFont = TextStyle(fontSize: 18);
  late Future<Skill> readAndUpdateSkillQuery;

  @override
  void initState() {
    super.initState();
    readAndUpdateSkillQuery = widget.repository.readSkill(widget.skillId);
  }

  @override
  Widget build(BuildContext context) {
    //TODO add a large graph showing cumulative progress (like in an investment portfolio)
    //TODO add widgets for adding/removing scheduled practice sessions
    return FutureBuilder(
      future: readAndUpdateSkillQuery,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('No connection', style: _biggerFont));
        } else {
          final skill = snapshot.data!;
          return Scaffold(
              appBar: AppBar(title: Text(skill.name)),
              body: SingleChildScrollView(
                  child: SizedBox(
                width: double.infinity,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Expanded(child: Text('Start'))),
                    DataColumn(label: Expanded(child: Text('End'))),
                    DataColumn(
                        label: Expanded(child: Text('Practice duration'))),
                    DataColumn(
                        label: Expanded(child: Text('Practices per week'))),
                    DataColumn(
                        label: Expanded(child: Text('Practice time to date'))),
                  ],
                  //TODO replace rows with actual data
                  rows: List<DataRow>.generate(
                      20,
                      (index) => DataRow(cells: [
                            DataCell(Text('Row $index')),
                            DataCell(Text('2023-01-08')),
                            DataCell(Text('1 hour')),
                            DataCell(Text('5')),
                            DataCell(Text('20 hours'))
                          ])),
                ),
              )));
          //TODO remove old code
          /*
          return Scaffold(
              appBar: AppBar(title: Text(skill.name)),
              body: Column(children: [
                Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        //Add an extra item to the list to trigger query.
                        itemCount: skill.weeklyPracticeScheduleIds.length * 2,
                        itemBuilder: (context, i) {
                          if (i.isOdd) return const Divider();
                          final index = i ~/ 2;
                          final scheduleId =
                              skill.weeklyPracticeScheduleIds[index];
                          return WeeklyPracticeScheduleListItem(
                              repository: widget.repository,
                              weeklyPracticeScheduleId: scheduleId);
                        })),
                Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: OutlinedButton.icon(
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text('Add schedule'),
                        onPressed: () {
                          //TODO add buttons later to adjust schedule parameters
                          widget.repository
                              .createWeeklyPracticeSchedule(
                                  startRecurrence: DateTime.now(),
                                  practiceDuration: const Duration(hours: 1),
                                  practiceSessionsPerWeek: 7)
                              .then((newSchedule) {
                            final skillWithAdditionalSchedule = Skill(
                                id: skill.id,
                                name: skill.name,
                                createdAt: skill.createdAt,
                                weeklyPracticeScheduleIds:
                                    skill.weeklyPracticeScheduleIds +
                                        [newSchedule.id]);
                            setState(() {
                              readAndUpdateSkillQuery = widget.repository
                                  .updateSkill(skillWithAdditionalSchedule);
                            });
                          });
                        }))
              ]));
           */
        }
      },
    );
  }
}
