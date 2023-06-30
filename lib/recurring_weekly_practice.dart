//TODO we may want to prevent users from adding recurring practice sessions whose start/end times overlap (e.g., practice for 1 hour every 30 minutes is not possible)
class RecurringWeeklyPractice {
  final DateTime startRecurrence;
  final DateTime? endRecurrence;
  final Duration practiceDuration;
  final int
      practiceSessionsPerWeek; //TODO originally we thought about allowing cron-like schedules, but this is probably better for the user experience

  RecurringWeeklyPractice(
      {required this.startRecurrence,
      this.endRecurrence,
      required this.practiceDuration,
      required this.practiceSessionsPerWeek});

  Duration getTimePracticedBetween(DateTime start, DateTime end) {
    final firstPracticeDateWithinWindow =
        start.isAfter(startRecurrence) ? start : startRecurrence;
    final DateTime lastPracticeDateWithinWindow;
    if (endRecurrence == null) {
      lastPracticeDateWithinWindow = end;
    } else {
      lastPracticeDateWithinWindow =
          end.isBefore(endRecurrence!) ? end : endRecurrence!;
    }
    if (firstPracticeDateWithinWindow.isAfter(lastPracticeDateWithinWindow)) {
      return Duration.zero;
    }
    final windowDuration =
        lastPracticeDateWithinWindow.difference(firstPracticeDateWithinWindow);
    final windowDurationWeeks = windowDuration.inMinutes / 60 / 24 / 7;
    return practiceDuration * practiceSessionsPerWeek * windowDurationWeeks;
  }
}
