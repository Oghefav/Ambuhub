class SignUpParams {
  final String name;
  final String email;
  final String phone;
  final String country;
  final String password;
  final String role;

  const SignUpParams({
    required this.name,
    required this.email,
    required this.phone,
    required this.country,
    required this.password,
    required this.role,
  });
}
