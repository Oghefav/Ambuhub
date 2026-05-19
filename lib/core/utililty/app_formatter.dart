import 'package:intl/intl.dart';


  // Formats: 1000 -> 1,000 or 1000.5 -> 1,000.50
  String formatCurrency(dynamic amount, {String symbol = "₦"}) {
    if (amount == null) return "";

    final formatter = NumberFormat.currency(
      symbol: symbol, 
    );

    // Handle both String and Number inputs safely
    double value = amount is String
        ? (double.tryParse(amount) ?? 0.0)
        : amount.toDouble();

    return formatter.format(value);
  }


extension StringExtensions on String {
  String toTitleCase() {
    if (isEmpty) return this;

    return split(' ')
        .map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(' ');
  }
}
