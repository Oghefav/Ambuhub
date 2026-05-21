import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:flutter/cupertino.dart';

void hireOnChange(
  ServiceEntity service,
  ValueNotifier<String?> errorText,
  ValueNotifier<DateTime?> selectedStartDate,
  ValueNotifier<DateTime?> selectedEndDate,
) {
  if (selectedStartDate.value == null || selectedEndDate.value == null) {
    return;
  }

  final start = _calendarDate(selectedStartDate.value!);
  final end = _calendarDate(selectedEndDate.value!);
  final today = _calendarDate(DateTime.now());

  if (start.isAfter(end) || start.day == end.day && start.month == end.month && start.year == end.year) {
    errorText.value = 'Adjust the period so the end is after the start.';
  } else if (!(start.day == today.day) && start.month == today.month && start.year == today.year && start.isBefore(today)) {
    errorText.value = 'Start date cannot be in the past.';
  }
  else if (!isEndDateInHireReturnWindow(
    selectedEndDate.value,
    service.hireReturnWindow,
  )) {
    errorText.value = 'Return must be on an allowed day (${service.hireReturnWindow?.formattedDaysOfWeek} WAT).';
  } else {
    errorText.value = null;
  } 
}

/// Calendar date only (ignores clock), for stable day comparisons.
DateTime hireCalendarDate(DateTime date) =>
    DateTime(date.year, date.month, date.day);

DateTime _calendarDate(DateTime date) => hireCalendarDate(date);

/// Inclusive day count between [start] and [end] (same day → 1).
int hireInclusiveDays(DateTime start, DateTime end) {
  final s = _calendarDate(start);
  final e = _calendarDate(end);
  if (e.isBefore(s)) return 0;
  return e.difference(s).inDays + 1;
}

/// Billing units for a hire span from [service.pricePeriod].
///
/// Rounds up partial periods (e.g. 8 days with `week` → 2 weeks).
/// Returns `null` when [end] is before [start] or [pricePeriod] is unknown.
///
/// Supports: `hour`, `day`, `week`, `month`, `year` (and `*ly` aliases).
int? hirePeriodUnitCount({
  required DateTime start,
  required DateTime end,
  required String? pricePeriod,
}) {
  final days = hireInclusiveDays(start, end);
  if (days == 0) return null;

  switch (_normalizePricePeriod(pricePeriod)) {
    case _HirePricePeriod.hour:
      return days * 24;
    case _HirePricePeriod.day:
      return days;
    case _HirePricePeriod.week:
      return (days + 6) ~/ 7; // ceil(days / 7)
    case _HirePricePeriod.month:
      return _inclusiveMonthUnits(_calendarDate(start), _calendarDate(end));
    case _HirePricePeriod.year:
      return _inclusiveYearUnits(_calendarDate(start), _calendarDate(end));
    case _HirePricePeriod.unknown:
      return null;
  }
}

enum _HirePricePeriod { hour, day, week, month, year, unknown }

_HirePricePeriod _normalizePricePeriod(String? pricePeriod) {
  final p = pricePeriod?.toLowerCase().trim() ?? '';
  switch (p) {
    case 'hour':
    case 'hourly':
      return _HirePricePeriod.hour;
    case 'day':
    case 'daily':
      return _HirePricePeriod.day;
    case 'week':
    case 'weekly':
      return _HirePricePeriod.week;
    case 'month':
    case 'monthly':
      return _HirePricePeriod.month;
    case 'year':
    case 'yearly':
      return _HirePricePeriod.year;
    default:
      return _HirePricePeriod.unknown;
  }
}

/// Calendar months spanned, rounded up (Jan 1–Jan 31 → 1, Jan 1–Feb 1 → 2).
int _inclusiveMonthUnits(DateTime start, DateTime end) {
  final months = (end.year - start.year) * 12 + (end.month - start.month);
  return months + 1;
}

/// Calendar years spanned, rounded up (2024–2024 → 1, 2024–2025 → 2).
int _inclusiveYearUnits(DateTime start, DateTime end) {
  return (end.year - start.year) + 1;
}

/// True when [endDate]'s weekday is in [window.daysOfWeek] and, if a time is set
/// on [endDate], it lies between [window.timeStart] and [window.timeEnd].
///
/// Date-only values from the picker (midnight) pass once the weekday is allowed;
/// the UI deadline is that day at [window.timeEnd] (WAT).
bool isEndDateInHireReturnWindow(
  DateTime? endDate,
  WeeklyTimeWindowEntity? window,
) {
  if (endDate == null || window == null) return false;
  if (window.daysOfWeek.isEmpty) return false;

  final day = _calendarDate(endDate);
  if (!window.daysOfWeek.contains(day.weekday)) return false;

  final startMin = _minutesFromHhMm(window.timeStart);
  final endMin = _minutesFromHhMm(window.timeEnd);
  if (startMin == null || endMin == null) return true;

  final hasTime =
      endDate.hour != 0 ||
      endDate.minute != 0 ||
      endDate.second != 0 ||
      endDate.millisecond != 0;
  if (!hasTime) return true;

  final pickedMin = endDate.hour * 60 + endDate.minute;
  if (endMin >= startMin) {
    return pickedMin >= startMin && pickedMin <= endMin;
  }
  // Overnight window (e.g. 22:00–06:00)
  return pickedMin >= startMin || pickedMin <= endMin;
}

int? _minutesFromHhMm(String value) {
  final trimmed = value.trim();
  if (trimmed.isEmpty) return null;
  final parts = trimmed.split(':');
  final h = int.tryParse(parts.first);
  if (h == null) return null;
  final m = parts.length > 1 ? int.tryParse(parts[1]) ?? 0 : 0;
  return h * 60 + m;
}
