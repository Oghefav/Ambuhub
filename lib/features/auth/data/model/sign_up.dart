import 'package:ambuhub/features/auth/domain/entities/sign_up_params.dart';

class ClientSignUpModel extends ClientSignUpParams {
  const ClientSignUpModel({
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.country,
    required super.password,
    required super.phone,
    required super.dateOfBirth,
    required super.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'dateOfBirth': dateOfBirth,
      'countryCode': country,
      'password': password,
      'role': role,
    };
  }
  factory ClientSignUpModel.fromJson(Map<String, dynamic> json) {
    return ClientSignUpModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      country: json['country'],
      password: json['password'],
      dateOfBirth: json['dateOfBirth'],
      role: json['role'],
    );
  }

  factory ClientSignUpModel.fromParams(ClientSignUpParams params) {
    return ClientSignUpModel(
      firstName: params.firstName,
      lastName: params.lastName,
      email: params.email,
      phone: params.phone,
      country: params.country,
      password: params.password,
      dateOfBirth: params.dateOfBirth,
      role: params.role,
      );
  }
}

class ServiceProviderSignUpModel extends ServiceProviderSignUpParams {
  const ServiceProviderSignUpModel({
    required super.firstName,
    required super.lastName,
    required super.businessName,
    super.websiteUrl,
    required super.physicalAddress,
    required super.email,
    required super.phone,
    required super.country,
    required super.password,
    required super.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'businessName': businessName,
      'website': websiteUrl,
      'physicalAddress': physicalAddress,
      'email': email,
      'phone': phone,
      'countryCode': country,
      'password': password,
      'role': role,
    };
  }

  factory ServiceProviderSignUpModel.fromJson(Map<String, dynamic> json) {
    return ServiceProviderSignUpModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      businessName: json['businessName'],
      websiteUrl: json['website'],
      physicalAddress: json['physicalAddress'],
      email: json['email'],
      phone: json['phone'],
      country: json['countryCode'],  
      password: json['password'],
      role: json['role'],
    );
  }

  factory ServiceProviderSignUpModel.fromParams(ServiceProviderSignUpParams params) {
    return ServiceProviderSignUpModel(
      firstName: params.firstName,
      lastName: params.lastName,
      businessName: params.businessName,
      websiteUrl: params.websiteUrl,
      physicalAddress: params.physicalAddress,
      email: params.email,
      phone: params.phone,
      country: params.country,
      password: params.password,
      role: params.role,
    );
  }
}