import 'package:flutter/material.dart';

/// Shared [FormFieldValidator]s and helpers for forms.
abstract final class FormValidators {
  FormValidators._();

  /// Latest calendar birth date that still satisfies [minimumAge] years old as of "today".
  static DateTime latestBirthDateForMinimumAge([int minimumAge = 13]) {
    final now = DateTime.now();
    return DateTime(now.year - minimumAge, now.month, now.day);
  }

  /// Fails when the person is **under** [minimumAge] (e.g. COPPA-style 13+).
  ///
  /// Uses [birthDate] when set (e.g. from the date picker); otherwise parses [value] as ISO `yyyy-MM-dd`.
  static FormFieldValidator<String> minimumAge({
    required DateTime? Function() birthDate,
    int minimumAge = 13,
    String errorText = 'You must be at least 13 years old',
  }) {
    return (String? value) {
      final fromPicker = birthDate();
      final parsed = value != null && value.trim().isNotEmpty
          ? DateTime.tryParse(value.trim())
          : null;
      final dob = fromPicker ?? parsed;
      if (dob == null) return null;

      final cutoff = latestBirthDateForMinimumAge(minimumAge);
      if (dob.isAfter(cutoff)) {
        return errorText;
      }
      return null;
    };
  }
}
