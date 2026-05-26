const String kPricingPeriodPlaceholder = 'Select period';

/// Menu options only (placeholder is shown as the field hint, not a menu row).
const List<String> kPricingPeriodMenuItems = [
  'Hourly',
  'Daily',
  'Weekly',
  'Monthly',
  'Yearly',
];

/// Maps UI label to API `pricePeriod` (`hour`, `day`, `week`, `month`, `year`).
String? pricingPeriodLabelToApi(String label) {
  switch (label.trim().toLowerCase()) {
    case 'hourly':
      return 'hour';
    case 'daily':
      return 'day';
    case 'weekly':
      return 'week';
    case 'monthly':
      return 'month';
    case 'yearly':
      return 'year';
    default:
      return null;
  }
}

/// Display line under price, e.g. `per day`.
String? pricePeriodPerLine(String? pricePeriod) {
  final normalized = pricePeriod?.trim().toLowerCase();
  if (normalized == null || normalized.isEmpty) return null;

  switch (normalized) {
    case 'hour':
      return 'per hour';
    case 'day':
      return 'per day';
    case 'week':
      return 'per week';
    case 'month':
      return 'per month';
    case 'year':
      return 'per year';
    default:
      return 'per $normalized';
  }
}
