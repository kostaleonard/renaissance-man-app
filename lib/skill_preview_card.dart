/// Contains the widget for skill preview cards on the home page.

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:renaissance_man/repository.dart';
import 'package:renaissance_man/skill.dart';
import 'package:renaissance_man/skill_page.dart';
import 'package:renaissance_man/weekly_practice_schedule.dart';

//TODO when a user closes the skill page after making changes, do those changes reflect on the card here?
class SkillPreviewCard extends StatefulWidget {
  final Repository repository;
  final int skillId;

  const SkillPreviewCard(
      {super.key, required this.repository, required this.skillId});

  @override
  State<StatefulWidget> createState() => _SkillPreviewCardState();
}

class _SkillPreviewCardState extends State<SkillPreviewCard> {
  late Future<Skill> readSkillQuery;
  late Future<List<WeeklyPracticeSchedule>> readWeeklyPracticeScheduleQuery;

  @override
  void initState() {
    super.initState();
    readSkillQuery = widget.repository.readSkill(widget.skillId);
    readWeeklyPracticeScheduleQuery = readSkillQuery.then((skill) => widget
        .repository
        .readWeeklyPracticeSchedules(skill.weeklyPracticeScheduleIds));
  }

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionDuration: const Duration(milliseconds: 350),
      transitionType: ContainerTransitionType.fade,
      closedBuilder: (context, openContainer) {
        return FutureBuilder(
            future: readSkillQuery,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(
                    child: Text('No connection'));
              } else {
                final skill = snapshot.data!;
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                      onTap: openContainer,
                      splashColor: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.12),
                      highlightColor: Colors.transparent,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0,
                                        top: 8.0,
                                        right: 8.0,
                                        bottom: 4.0),
                                    child: Text(
                                      skill.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ))),
                            FutureBuilder(
                                future: readWeeklyPracticeScheduleQuery,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return const Center(
                                        child: Text('No connection'));
                                  } else {
                                    final weeklyPracticeSchedules =
                                        snapshot.data!;
                                    final now = DateTime.now();
                                    final today =
                                        DateTime(now.year, now.month, now.day);
                                    final weeklyPracticeSchedulesTotalDuration =
                                        weeklyPracticeSchedules.map(
                                            (schedule) => schedule
                                                .getTimePracticedBetween(
                                                    schedule.startRecurrence,
                                                    schedule.endRecurrence ??
                                                        today));
                                    final totalPracticeDuration =
                                        weeklyPracticeSchedules.isEmpty
                                            ? Duration.zero
                                            : weeklyPracticeSchedulesTotalDuration
                                                .reduce((value, element) =>
                                                    value + element);
                                    return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0,
                                            top: 4.0,
                                            right: 8.0,
                                            bottom: 4.0),
                                        child: Text(
                                          _getDurationDisplayString(
                                              totalPracticeDuration),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ));
                                  }
                                })
                          ])),
                );
              }
            });
      },
      openBuilder: (context, closeContainer) {
        return SkillPage(
          repository: widget.repository,
          skillId: widget.skillId,
        );
      },
      onClosed: (_) {
        setState(() {
          readSkillQuery = widget.repository.readSkill(widget.skillId);
          readWeeklyPracticeScheduleQuery = readSkillQuery.then((skill) =>
              widget.repository.readWeeklyPracticeSchedules(
                  skill.weeklyPracticeScheduleIds));
        });
      },
    );
  }

  String _getDurationDisplayString(Duration duration) {
    final hours = duration.inHours;
    final String hoursSummary;
    if (hours == 1) {
      hoursSummary = '1 hour';
    } else if (hours > 1000) {
      hoursSummary = '${(hours / 1000).floor()}k hours';
    } else {
      hoursSummary = '$hours hours';
    }
    return hoursSummary;
  }
}
