import 'package:flutter/material.dart';

Future<void> hireSelectDate(
  BuildContext context,
  TextEditingController dateController,
  ValueNotifier<DateTime?> selectedDate,) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    firstDate: DateTime(1950),
    initialDate: DateTime.now(),
    lastDate: DateTime(2101),
    // Customizing the calendar colors to match Ambuhub
    builder: (context, child) {
      return Transform.scale(scale: 0.8, child: child);
    },
  );

  if (picked != null && picked != selectedDate.value) {
    selectedDate.value = picked;
    dateController.text = selectedDate.value?.toString().split(' ')[0] ?? '';
  }
}
