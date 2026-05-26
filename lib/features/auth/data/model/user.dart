import 'package:ambuhub/features/auth/domain/entities/client.dart';
import 'package:ambuhub/features/auth/domain/entities/service_provider.dart';
import 'package:ambuhub/features/auth/domain/entities/update_profile_params.dart';
import 'package:ambuhub/features/auth/domain/entities/update_provider_profile_params.dart';

String _firstNonEmpty(Iterable<String?> values) {
  for (final value in values) {
    if (value != null && value.trim().isNotEmpty) {
      return value.trim();
    }
  }
  return '';
}

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
      id: json['id']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      firstName: json['firstName']?.toString() ?? '',
      lastName: json['lastName']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      country:
          json['countryCode']?.toString() ?? json['country']?.toString() ?? '',
      dateOfBirth:
          json['dateOfBirth']?.toString() ??
          json['date_of_birth']?.toString() ??
          '',
      role: json['role']?.toString() ?? '',
    );
  }

  /// Fills gaps when the profile API returns a partial user object.
  ClientModel mergedFromUpdate({
    required UpdateProfileParams submitted,
    ClientEntity? previous,
  }) {
    return ClientModel(
      id: _firstNonEmpty([id, previous?.id]),
      email: _firstNonEmpty([email, submitted.email, previous?.email]),
      firstName: _firstNonEmpty([
        firstName,
        submitted.firstName,
        previous?.firstName,
      ]),
      lastName: _firstNonEmpty([
        lastName,
        submitted.lastName,
        previous?.lastName,
      ]),
      phone: _firstNonEmpty([phone, submitted.phone, previous?.phone]),
      country: _firstNonEmpty([country, submitted.country, previous?.country]),
      dateOfBirth: _firstNonEmpty([
        dateOfBirth,
        submitted.dateOfBirth,
        previous?.dateOfBirth,
      ]),
      role: _firstNonEmpty([role, previous?.role]),
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
    final website = json['website']?.toString().trim();
    return ServiceProviderModel(
      id: json['id']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      firstName: json['firstName']?.toString() ?? '',
      lastName: json['lastName']?.toString() ?? '',
      businessName: json['businessName']?.toString() ?? '',
      websiteUrl: website != null && website.isNotEmpty ? website : null,
      physicalAddress: json['physicalAddress']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      country:
          json['countryCode']?.toString() ?? json['country']?.toString() ?? '',
      role: json['role']?.toString() ?? '',
    );
  }

  ServiceProviderModel mergedFromUpdate({
    required UpdateProviderProfileParams submitted,
    ServiceProviderEntity? previous,
  }) {
    final submittedWebsite = submitted.websiteUrl?.trim();
    return ServiceProviderModel(
      id: _firstNonEmpty([id, previous?.id]),
      email: _firstNonEmpty([email, previous?.email]),
      firstName: _firstNonEmpty([
        firstName,
        submitted.firstName,
        previous?.firstName,
      ]),
      lastName: _firstNonEmpty([
        lastName,
        submitted.lastName,
        previous?.lastName,
      ]),
      phone: _firstNonEmpty([phone, submitted.phone, previous?.phone]),
      country: _firstNonEmpty([country, submitted.country, previous?.country]),
      businessName: _firstNonEmpty([
        businessName,
        submitted.businessName,
        previous?.businessName,
      ]),
      websiteUrl: () {
        final merged = _firstNonEmpty([
          websiteUrl,
          submittedWebsite,
          previous?.websiteUrl,
        ]);
        return merged.isEmpty ? null : merged;
      }(),
      physicalAddress: _firstNonEmpty([
        physicalAddress,
        submitted.physicalAddress,
        previous?.physicalAddress,
      ]),
      role: _firstNonEmpty([role, previous?.role]),
    );
  }
}
