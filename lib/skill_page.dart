/// Displays an in-depth view of a single skill.

import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/helpers/show_number_picker.dart';
import 'package:renaissance_man/repository.dart';
import 'package:renaissance_man/skill.dart';
import 'package:renaissance_man/weekly_practice_schedule.dart';

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
  late Future<List<WeeklyPracticeSchedule>> readWeeklyPracticeScheduleQuery;
  late DateTime newWeeklyPracticeScheduleStartDate;
  DateTime? newWeeklyPracticeScheduleEndDate;
  Duration newWeeklyPracticeScheduleDuration = const Duration(minutes: 30);
  int newWeeklyPracticeScheduleSessionsPerWeek = 5;

  @override
  void initState() {
    super.initState();
    readAndUpdateSkillQuery = widget.repository.readSkill(widget.skillId);
    readWeeklyPracticeScheduleQuery = readAndUpdateSkillQuery.then((skill) =>
        widget.repository
            .readWeeklyPracticeSchedules(skill.weeklyPracticeScheduleIds));
    final now = DateTime.now();
    newWeeklyPracticeScheduleStartDate = DateTime(now.year, now.month, now.day);
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
          //TODO always show header column
          //TODO add column with empty header for X and check marks to remove and add schedules (add only for the last row). These buttons should be subdued.
          return Scaffold(
              appBar: AppBar(title: Text(skill.name)),
              body: FutureBuilder(
                  future: readWeeklyPracticeScheduleQuery,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(
                          child: Text('No connection', style: _biggerFont));
                    } else {
                      final weeklyPracticeSchedules = snapshot.data!;
                      return SingleChildScrollView(
                          child: SizedBox(
                        width: double.infinity,
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Flexible(child: Text('Start'))),
                            DataColumn(label: Flexible(child: Text('End'))),
                            DataColumn(
                                label: Flexible(
                                    child: Text('Practice\nduration'))),
                            DataColumn(
                                label: Flexible(
                                    child: Text('Practices\nper week'))),
                            DataColumn(
                                label: Flexible(
                                    child: Text('Practice time\nto date'))),
                            //This column contains the add and remove schedule buttons.
                            DataColumn(label: Flexible(child: Text(''))),
                          ],
                          //TODO replace rows with actual data
                          rows: List<DataRow>.generate(
                                  weeklyPracticeSchedules.length, (index) {
                                final schedule = weeklyPracticeSchedules[index];
                                final now = DateTime.now();
                                final today =
                                    DateTime(now.year, now.month, now.day);
                                return DataRow(cells: [
                                  DataCell(Text(
                                      '${schedule.startRecurrence.year}-${schedule.startRecurrence.month}-${schedule.startRecurrence.day}')),
                                  DataCell(Text(schedule.endRecurrence == null
                                      ? 'None'
                                      : '${schedule.endRecurrence!.year}-${schedule.endRecurrence!.month}-${schedule.endRecurrence!.day}')),
                                  DataCell(Text(_getDurationDisplayString(
                                      schedule.practiceDuration))),
                                  DataCell(Text(
                                      '${schedule.practiceSessionsPerWeek}')),
                                  DataCell(Text(_getDurationDisplayString(
                                      schedule.getTimePracticedBetween(
                                          schedule.startRecurrence,
                                          schedule.endRecurrence ?? today)))),
                                  //TODO remove element
                                  DataCell(IconButton(
                                    icon:
                                        const Icon(Icons.remove_circle_outline),
                                    onPressed: () {},
                                  )),
                                ]);
                              }) +
                              [
                                DataRow(cells: [
                                  DataCell(OutlinedButton(
                                    child: Text(
                                        '${newWeeklyPracticeScheduleStartDate.year}-${newWeeklyPracticeScheduleStartDate.month}-${newWeeklyPracticeScheduleStartDate.day}'),
                                    onPressed: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate:
                                                  newWeeklyPracticeScheduleStartDate,
                                              firstDate: DateTime(1900),
                                              lastDate:
                                                  newWeeklyPracticeScheduleEndDate ??
                                                      DateTime(2100))
                                          .then((newStartDate) {
                                        if (newStartDate != null) {
                                          setState(() {
                                            newWeeklyPracticeScheduleStartDate =
                                                newStartDate;
                                          });
                                        }
                                      });
                                    },
                                  )),
                                  DataCell(Row(
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              newWeeklyPracticeScheduleEndDate =
                                                  null;
                                            });
                                          },
                                          child: const Icon(Icons.cancel)),
                                      OutlinedButton(
                                        child: Text(
                                            newWeeklyPracticeScheduleEndDate ==
                                                    null
                                                ? 'None'
                                                : '${newWeeklyPracticeScheduleEndDate!.year}-${newWeeklyPracticeScheduleEndDate!.month}-${newWeeklyPracticeScheduleEndDate!.day}'),
                                        onPressed: () {
                                          showDatePicker(
                                                  context: context,
                                                  initialDate:
                                                      newWeeklyPracticeScheduleEndDate ??
                                                          newWeeklyPracticeScheduleStartDate,
                                                  firstDate:
                                                      newWeeklyPracticeScheduleStartDate,
                                                  lastDate: DateTime(2100))
                                              .then((newEndDate) {
                                            if (newEndDate != null) {
                                              setState(() {
                                                newWeeklyPracticeScheduleEndDate =
                                                    newEndDate;
                                              });
                                            }
                                          });
                                        },
                                      )
                                    ],
                                  )),
                                  DataCell(OutlinedButton(
                                    child: Text(_getDurationDisplayString(
                                        newWeeklyPracticeScheduleDuration)),
                                    onPressed: () {
                                      showMaterialNumberPicker(
                                        context: context,
                                        title: 'Select practice duration',
                                        maxNumber: 60 * 24,
                                        minNumber: 0,
                                        selectedNumber:
                                            newWeeklyPracticeScheduleDuration
                                                .inMinutes,
                                        step: 5,
                                        onChanged: (value) => setState(() =>
                                            newWeeklyPracticeScheduleDuration =
                                                Duration(minutes: value)),
                                      );
                                    },
                                  )),
                                  DataCell(OutlinedButton(
                                    child: Text(
                                        newWeeklyPracticeScheduleSessionsPerWeek
                                            .toString()),
                                    onPressed: () {
                                      showMaterialNumberPicker(
                                          context: context,
                                          title: 'Select practices per week',
                                          maxNumber: 7 * 10,
                                          minNumber: 0,
                                          selectedNumber:
                                              newWeeklyPracticeScheduleSessionsPerWeek,
                                          onChanged: (value) => setState(() =>
                                              newWeeklyPracticeScheduleSessionsPerWeek =
                                                  value));
                                    },
                                  )),
                                  DataCell(Text(
                                    _getDurationDisplayString(
                                        _getNewWeeklyPracticeScheduleProjectedTimePracticed()),
                                    style: const TextStyle(color: Colors.grey),
                                  )),
                                  DataCell(IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      widget.repository
                                          .createWeeklyPracticeSchedule(
                                              startRecurrence:
                                                  newWeeklyPracticeScheduleStartDate,
                                              endRecurrence:
                                                  newWeeklyPracticeScheduleEndDate,
                                              practiceDuration:
                                                  newWeeklyPracticeScheduleDuration,
                                              practiceSessionsPerWeek:
                                                  newWeeklyPracticeScheduleSessionsPerWeek)
                                          .then((newSchedule) {
                                        final skillWithAdditionalSchedule = Skill(
                                            id: skill.id,
                                            name: skill.name,
                                            createdAt: skill.createdAt,
                                            weeklyPracticeScheduleIds: skill
                                                    .weeklyPracticeScheduleIds +
                                                [newSchedule.id]);
                                        setState(() {
                                          readAndUpdateSkillQuery =
                                              widget.repository.updateSkill(
                                                  skillWithAdditionalSchedule);
                                          readWeeklyPracticeScheduleQuery =
                                              readAndUpdateSkillQuery.then(
                                                  (skill) => widget.repository
                                                      .readWeeklyPracticeSchedules(
                                                          skill
                                                              .weeklyPracticeScheduleIds));
                                        });
                                      });
                                    },
                                  ))
                                ])
                              ],
                        ),
                      ));
                    }
                  }));
        }
      },
    );
  }

  String _getDurationDisplayString(Duration duration) {
    final hours = (duration.inMinutes / 60).floor();
    final minutes = duration.inMinutes % 60;
    final String hoursPortion;
    if (hours > 1) {
      hoursPortion = '$hours hours';
    } else if (hours == 1) {
      hoursPortion = '1 hour';
    } else {
      hoursPortion = '';
    }
    final String minutesPortion;
    if (minutes == 1) {
      minutesPortion = '1 minute';
    } else if (minutes > 1 || hours == 0) {
      minutesPortion = '$minutes minutes';
    } else {
      minutesPortion = '';
    }
    return hoursPortion.isNotEmpty && minutesPortion.isNotEmpty
        ? '$hoursPortion, $minutesPortion'
        : '$hoursPortion$minutesPortion';
  }

  Duration _getNewWeeklyPracticeScheduleProjectedTimePracticed() {
    final schedule = WeeklyPracticeSchedule(
        id: -1,
        startRecurrence: newWeeklyPracticeScheduleStartDate,
        endRecurrence: newWeeklyPracticeScheduleEndDate,
        practiceDuration: newWeeklyPracticeScheduleDuration,
        practiceSessionsPerWeek: newWeeklyPracticeScheduleSessionsPerWeek);
    final now = DateTime.now();
    final DateTime endDateForProjection;
    if (schedule.endRecurrence == null) {
      endDateForProjection = DateTime(now.year, now.month, now.day);
    } else if (schedule.endRecurrence!.isAfter(now)) {
      endDateForProjection = DateTime(now.year, now.month, now.day);
    } else {
      endDateForProjection = schedule.endRecurrence!;
    }
    return schedule.getTimePracticedBetween(
        schedule.startRecurrence, endDateForProjection);
  }
}
