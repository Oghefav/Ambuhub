import 'package:equatable/equatable.dart';

class ServiceProviderEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String businessName;
  final String? websiteUrl;
  final String physicalAddress;
  final String email;
  final String phone;
  final String country;
  final String role;

  const ServiceProviderEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.businessName,
    this.websiteUrl,
    required this.physicalAddress,
    required this.email,
    required this.phone,
    required this.country,
    required this.role,
  });

  @override
  List<Object?> get props => [id, businessName, email];
}
