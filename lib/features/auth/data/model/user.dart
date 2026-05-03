import 'package:ambuhub/features/auth/domain/entities/client.dart';
import 'package:ambuhub/features/auth/domain/entities/service_provider.dart';

class ClientModel extends ClientEntity {
  const ClientModel({
    required super.id,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.phone,
    required super.country,
    required super.dateOfBirth,
    required super.role,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      phone: json['phone'] ?? '' ,
      country: json['countryCode'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      role: json['role'] ?? '',
      );
  }
}

class ServiceProviderModel extends ServiceProviderEntity {
  const ServiceProviderModel({
    required super.id,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.businessName,
    super.websiteUrl,
    required super.physicalAddress,
    required super.phone,
    required super.country,
    required super.role,
  });

  factory ServiceProviderModel.fromJson(Map<String, dynamic> json) {
    return ServiceProviderModel(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      businessName: json['businessName'] ?? '',
      websiteUrl: json['website'] ?? '',
      physicalAddress: json['physicalAddress'] ?? '',
      phone: json['phone'] ?? '',
      country: json['countryCode'] ?? '',
      role: json['role'],
    );
  }
}