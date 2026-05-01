class ClientSignUpParams {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String country;
  final String password;
  final String dateOfBirth;
  final String role;

  const ClientSignUpParams({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.country,
    required this.password,
    required this.dateOfBirth,
    required this.role,
  });
}

class ServiceProviderSignUpParams {
  final String firstName;
  final String lastName;
  final String businessName;
  final String? websiteUrl;
  final String physicalAddress;
  final String email;
  final String phone;
  final String country;
  final String password;
  final String role;

  const ServiceProviderSignUpParams({
    required this.firstName,
    required this.lastName,
    required this.businessName,
    this.websiteUrl,
    required this.physicalAddress,
    required this.email,
    required this.phone,
    required this.country,
    required this.password,
    required this.role,
  });
}
