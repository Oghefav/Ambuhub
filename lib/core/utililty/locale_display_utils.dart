import 'package:country_picker/country_picker.dart';
import 'package:intl/intl.dart';

/// Parses [value] when it is a [DateTime] or ISO-8601 string
/// (e.g. `"2026-05-15T19:38:42.855Z"`).
DateTime? tryParseDateTime(dynamic value) {
  if (value == null) return null;
  if (value is DateTime) return value;
  if (value is String) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return null;
    return DateTime.tryParse(trimmed);
  }
  return null;
}

/// Long display label, e.g. `Wednesday, May 20, 2026, 4:00 PM`.
///
/// Accepts [DateTime] or an ISO string. By default converts UTC API timestamps
/// to the device local timezone before formatting.
String formatDateTimeLong(
  dynamic value, {
  String locale = 'en',
  bool toLocal = true,
}) {
  final parsed = tryParseDateTime(value);
  if (parsed == null) return '';
  final dt = toLocal ? parsed.toLocal() : parsed;
  return DateFormat('EEEE, MMMM d, y', locale).format(dt);
}

/// Same as [formatDateTimeLong], but returns null when [value] cannot be parsed.
String? formatDateTimeLongOrNull(
  dynamic value, {
  String locale = 'en',
  bool toLocal = true,
}) {
  final parsed = tryParseDateTime(value);
  if (parsed == null) return null;
  final dt = toLocal ? parsed.toLocal() : parsed;
  return DateFormat('EEEE, MMMM d, y, h:mm a', locale).format(dt);
}
String? formatDateTimeclockTime(
  dynamic value, {
  String locale = 'en',
  bool toLocal = true,
}) {
  final parsed = tryParseDateTime(value);
  if (parsed == null) return null;
  final dt = toLocal ? parsed.toLocal() : parsed;
  return DateFormat(' h:mm a', locale).format(dt);
}

/// Review date only, e.g. `May 22, 2026`.
String? formatReviewDateOrNull(
  dynamic value, {
  String locale = 'en',
  bool toLocal = true,
}) {
  final parsed = tryParseDateTime(value);
  if (parsed == null) return null;
  final dt = toLocal ? parsed.toLocal() : parsed;
  return DateFormat('MMMM d, y', locale).format(dt);
}

/// Review timestamp, e.g. `May 22, 2026, 12:25 PM`.
String? formatReviewDateTimeOrNull(
  dynamic value, {
  String locale = 'en',
  bool toLocal = true,
}) {
  final parsed = tryParseDateTime(value);
  if (parsed == null) return null;
  final dt = toLocal ? parsed.toLocal() : parsed;
  return DateFormat('MMMM d, y, h:mm a', locale).format(dt);
}

/// Short US-style label, e.g. `5/21/2026, 9:13:54 PM`.
String formatDateTimeShort(
  dynamic value, {
  String locale = 'en',
  bool toLocal = true,
}) {
  final parsed = tryParseDateTime(value);
  if (parsed == null) return '';
  final dt = toLocal ? parsed.toLocal() : parsed;
  return DateFormat('M/d/yyyy, h:mm:ss a', locale).format(dt);
}

/// Office region line for display, e.g. `Bayelsa, Nigeria`.
String formatLocationRegionLine({
  String? stateProvinceName,
  String? stateProvince,
  String? country,
}) {
  final stateRaw = _firstNonEmptyTrimmed([stateProvinceName, stateProvince]);
  final state = stateRaw == null ? null : _formatPlaceLabel(stateRaw);

  final countryRaw = country?.trim();
  final countryName = (countryRaw == null || countryRaw.isEmpty)
      ? null
      : _formatPlaceLabel(
          countryCodeToCountryName(countryRaw) ?? countryRaw,
        );

  if (state != null && countryName != null) {
    return '$state, $countryName';
  }
  return state ?? countryName ?? '';
}

String? _firstNonEmptyTrimmed(List<String?> values) {
  for (final value in values) {
    final trimmed = value?.trim();
    if (trimmed != null && trimmed.isNotEmpty) return trimmed;
  }
  return null;
}

String _formatPlaceLabel(String value) {
  final trimmed = value.trim();
  if (trimmed.isEmpty) return trimmed;
  if (trimmed.length <= 2) return trimmed.toUpperCase();
  return trimmed
      .split(RegExp(r'\s+'))
      .map((word) {
        if (word.isEmpty) return word;
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      })
      .join(' ');
}

/// Resolves ISO 3166-1 alpha-2 [code] (e.g. `"NG"`) to the picker’s display name.
/// Returns null if [code] is empty or unknown.
String? countryCodeToCountryName(String? code) {
  if (code == null || code.trim().isEmpty) return null;
  final upper = code.trim().toUpperCase();
  for (final country in CountryService().getAll()) {
    if (country.countryCode.toUpperCase() == upper) {
      return country.name;
    }
  }
  return null;
}

/// [weekday] uses the same convention as [DateTime.weekday]:
/// **1 = Monday** … **7 = Sunday**.
///
/// If your API uses **0 = Sunday** … **6 = Saturday** (like JS `getDay()`),
/// convert first: `dartWeekday = jsDay == 0 ? 7 : jsDay` (then 1–7 = Mon–Sun
/// except Sunday stays 7), or map explicitly — tell me your API rule if unsure.
String weekdayNumberToName(
  int weekday, {
  String locale = 'en',
}) {
  if (weekday < 1 || weekday > 7) return '';
  // 2024-01-01 is a Monday in UTC; adding days keeps weekday labels correct.
  final monday = DateTime.utc(2024, 1, 1);
  final date = monday.add(Duration(days: weekday - 1));
  return DateFormat.EEEE(locale).format(date);
}

/// Short label (e.g. Mon, Tue) in [locale].
String weekdayNumberToShortName(
  int weekday, {
  String locale = 'en',
}) {
  if (weekday < 1 || weekday > 7) return '';
  final monday = DateTime.utc(2024, 1, 1);
  final date = monday.add(Duration(days: weekday - 1));
  return DateFormat('EEE', locale).format(date);
}

/// Formats [daysOfWeek] for display (1 = Monday … 7 = Sunday).
///
/// Consecutive days become a range; gaps start a new segment. Segments are
/// joined with `", "`.
///
/// Examples:
/// - `[1, 2, 3, 4, 5]` → `Mon - Fri`
/// - `[1, 2]` → `Mon - Tue`
/// - `[2, 5]` → `Tue, Fri`
/// - `[1, 2, 4, 5]` → `Mon - Tue, Thu - Fri`
/// - `[1, 3, 5]` → `Mon, Wed, Fri`
String formatDaysOfWeek(
  Iterable<int> daysOfWeek, {
  String locale = 'en',
}) {
  final sorted = daysOfWeek.where((d) => d >= 1 && d <= 7).toSet().toList()
    ..sort();
  if (sorted.isEmpty) return '';

  final segments = <String>[];
  var rangeStart = sorted.first;
  var rangeEnd = sorted.first;

  for (var i = 1; i < sorted.length; i++) {
    final day = sorted[i];
    if (day == rangeEnd + 1) {
      rangeEnd = day;
    } else {
      segments.add(_formatWeekdayRange(rangeStart, rangeEnd, locale: locale));
      rangeStart = day;
      rangeEnd = day;
    }
  }
  segments.add(_formatWeekdayRange(rangeStart, rangeEnd, locale: locale));
  return segments.join(', ');
}

String _formatWeekdayRange(int start, int end, {required String locale}) {
  final startLabel = weekdayNumberToShortName(start, locale: locale);
  if (start == end) return startLabel;
  final endLabel = weekdayNumberToShortName(end, locale: locale);
  return '$startLabel - $endLabel';
}

List<String> weekdayNumbersToNames(
  Iterable<int> weekdays, {
  String locale = 'en',
  bool shortNames = false,
}) {
  return weekdays
      .map(
        (d) => shortNames
            ? weekdayNumberToShortName(d, locale: locale)
            : weekdayNumberToName(d, locale: locale),
      )
      .toList();
}
