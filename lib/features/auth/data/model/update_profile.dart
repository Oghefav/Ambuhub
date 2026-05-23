import 'package:ambuhub/features/auth/domain/entities/update_profile_params.dart';

class UpdateProfileModel {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String country;
  final String dateOfBirth;

  const UpdateProfileModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.country,
    required this.dateOfBirth,
  });

  factory UpdateProfileModel.fromParams(UpdateProfileParams params) {
    return UpdateProfileModel(
      firstName: params.firstName,
      lastName: params.lastName,
      email: params.email,
      phone: params.phone,
      country: params.country,
      dateOfBirth: params.dateOfBirth,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'dateOfBirth': dateOfBirth,
      'countryCode': country,
    };
  }
}
