/// Normalizes API/user role strings for routing and model parsing.
bool isClientRole(String? role) {
  final normalized = role?.toLowerCase().trim();
  return normalized == 'patient' || normalized == 'client';
}

bool isServiceProviderRole(String? role) {
  final normalized = role?.toLowerCase().trim().replaceAll(' ', '_');
  return normalized == 'service_provider';
}
