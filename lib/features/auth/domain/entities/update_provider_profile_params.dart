import 'package:equatable/equatable.dart';

class UpdateProviderProfileParams extends Equatable {
  final String firstName;
  final String lastName;
  final String phone;
  final String country;
  final String businessName;
  final String? websiteUrl;
  final String physicalAddress;

  const UpdateProviderProfileParams({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.country,
    required this.businessName,
    this.websiteUrl,
    required this.physicalAddress,
  });

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        phone,
        country,
        businessName,
        websiteUrl,
        physicalAddress,
      ];
}
