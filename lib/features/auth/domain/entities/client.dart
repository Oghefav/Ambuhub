import 'package:equatable/equatable.dart';

class ClientEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String country;
  final String dateOfBirth;
  final String role;

  const ClientEntity({
    required this.firstName,
    required this.lastName,
    required this.id,
    required this.email,
    required this.phone,
    required this.country,
    required this.dateOfBirth,
    required this.role,
  });


  @override
  List<Object> get props => [id, email];
}
