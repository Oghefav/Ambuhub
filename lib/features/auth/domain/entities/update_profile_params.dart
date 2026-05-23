import 'package:equatable/equatable.dart';

class UpdateProfileParams extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String country;
  final String dateOfBirth;

  const UpdateProfileParams({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.country,
    required this.dateOfBirth,
  });

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        phone,
        country,
        dateOfBirth,
      ];
}
