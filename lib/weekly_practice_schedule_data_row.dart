/// Displays a WeeklyPracticeSchedule in a DataRow.

import 'package:flutter/material.dart';
import 'package:renaissance_man/repository.dart';
import 'package:renaissance_man/weekly_practice_schedule.dart';

class WeeklyPracticeScheduleDataRow extends StatefulWidget {
  final Repository repository;
  final int weeklyPracticeScheduleId;

  const WeeklyPracticeScheduleDataRow(
      {Key? key,
      required this.repository,
      required this.weeklyPracticeScheduleId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _WeeklyPracticeScheduleDataRowState();
}

class _WeeklyPracticeScheduleDataRowState
    extends State<WeeklyPracticeScheduleDataRow> {
  static const _biggerFont = TextStyle(fontSize: 18);
  late Future<WeeklyPracticeSchedule> readWeeklyPracticeScheduleQuery;

  @override
  void initState() {
    super.initState();
    readWeeklyPracticeScheduleQuery = widget.repository
        .readWeeklyPracticeSchedule(widget.weeklyPracticeScheduleId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: readWeeklyPracticeScheduleQuery,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('No connection', style: _biggerFont));
        } else {
          final schedule = snapshot.data!;
          //TODO better display for schedule
          return ListTile(
            leading: const Icon(Icons.timer),
            title: Text(
              schedule.startRecurrence.toString(),
              style: _biggerFont,
            ),
          );
        }
      },
    );
  }
}
