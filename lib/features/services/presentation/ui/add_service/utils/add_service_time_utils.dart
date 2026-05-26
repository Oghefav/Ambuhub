import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:flutter/material.dart';

String formatTimeOfDayDisplay(TimeOfDay time) {
  final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
  final minute = time.minute.toString().padLeft(2, '0');
  final period = time.period == DayPeriod.am ? 'AM' : 'PM';
  return '$hour:$minute $period';
}

String timeOfDayToApi(TimeOfDay time) {
  final h = time.hour.toString().padLeft(2, '0');
  final m = time.minute.toString().padLeft(2, '0');
  return '$h:$m';
}

bool isReturnWindowValid(TimeOfDay from, TimeOfDay until) {
  final fromMin = from.hour * 60 + from.minute;
  final untilMin = until.hour * 60 + until.minute;
  return untilMin > fromMin;
}

WeeklyTimeWindowEntity buildHireReturnWindow({
  required Set<int> days,
  required TimeOfDay from,
  required TimeOfDay until,
}) {
  final sortedDays = days.toList()..sort();
  return WeeklyTimeWindowEntity(
    daysOfWeek: sortedDays,
    timeStart: timeOfDayToApi(from),
    timeEnd: timeOfDayToApi(until),
  );
}

Future<TimeOfDay?> pickReturnTime(
  BuildContext context, {
  required TimeOfDay initial,
}) {
  return showTimePicker(
    context: context,
    initialTime: initial,
    builder: (context, child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
        child: child ?? const SizedBox.shrink(),
      );
    },
  );
}
