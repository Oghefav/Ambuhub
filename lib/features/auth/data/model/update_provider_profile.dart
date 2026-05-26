import 'package:ambuhub/features/auth/domain/entities/update_provider_profile_params.dart';

class UpdateProviderProfileModel {
  final String firstName;
  final String lastName;
  final String phone;
  final String country;
  final String businessName;
  final String? websiteUrl;
  final String physicalAddress;

  const UpdateProviderProfileModel({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.country,
    required this.businessName,
    this.websiteUrl,
    required this.physicalAddress,
  });

  factory UpdateProviderProfileModel.fromParams(
    UpdateProviderProfileParams params,
  ) {
    return UpdateProviderProfileModel(
      firstName: params.firstName,
      lastName: params.lastName,
      phone: params.phone,
      country: params.country,
      businessName: params.businessName,
      websiteUrl: params.websiteUrl,
      physicalAddress: params.physicalAddress,
    );
  }

  Map<String, dynamic> toJson() {
    final website = websiteUrl?.trim();
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'countryCode': country,
      'businessName': businessName,
      'physicalAddress': physicalAddress,
      if (website != null && website.isNotEmpty) 'website': website,
    };
  }
}
