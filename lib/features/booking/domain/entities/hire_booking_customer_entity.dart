import 'package:equatable/equatable.dart';

class HireBookingCustomerEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;

  const HireBookingCustomerEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
  });

  String get displayName {
    final name = '${firstName.trim()} ${lastName.trim()}'.trim();
    if (name.isNotEmpty) return name;
    return email.trim().isNotEmpty ? email.trim() : 'Customer';
  }

  @override
  List<Object?> get props => [id, firstName, lastName, email, phone];
}
