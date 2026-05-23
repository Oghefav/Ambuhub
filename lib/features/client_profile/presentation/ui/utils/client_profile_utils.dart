import 'package:ambuhub/features/auth/domain/entities/client.dart';

bool isClientProfileComplete(ClientEntity client) {
  return client.id.trim().isNotEmpty &&
      client.firstName.trim().isNotEmpty &&
      client.lastName.trim().isNotEmpty &&
      client.email.trim().isNotEmpty &&
      client.phone.trim().isNotEmpty &&
      client.country.trim().isNotEmpty &&
      client.dateOfBirth.trim().isNotEmpty;
}
