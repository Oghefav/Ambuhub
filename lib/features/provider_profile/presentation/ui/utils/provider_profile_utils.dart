import 'package:ambuhub/features/auth/domain/entities/service_provider.dart';

bool isProviderProfileComplete(ServiceProviderEntity provider) {
  return provider.id.trim().isNotEmpty &&
      provider.firstName.trim().isNotEmpty &&
      provider.lastName.trim().isNotEmpty &&
      provider.email.trim().isNotEmpty &&
      provider.phone.trim().isNotEmpty &&
      provider.country.trim().isNotEmpty &&
      provider.businessName.trim().isNotEmpty &&
      provider.physicalAddress.trim().isNotEmpty;
}
