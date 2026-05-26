import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:equatable/equatable.dart';

class UpdateServiceAvailabilityState extends Equatable {
  final Set<String> updatingServiceIds;
  final String? errorMessage;
  final ServiceEntity? lastUpdatedService;
  final String? patchedServiceId;
  final bool? patchedIsAvailable;

  const UpdateServiceAvailabilityState({
    this.updatingServiceIds = const {},
    this.errorMessage,
    this.lastUpdatedService,
    this.patchedServiceId,
    this.patchedIsAvailable,
  });

  bool isUpdating(String serviceId) => updatingServiceIds.contains(serviceId);

  UpdateServiceAvailabilityState copyWith({
    Set<String>? updatingServiceIds,
    String? errorMessage,
    ServiceEntity? lastUpdatedService,
    String? patchedServiceId,
    bool? patchedIsAvailable,
    bool clearError = false,
    bool clearLastUpdated = false,
    bool clearPatch = false,
  }) {
    return UpdateServiceAvailabilityState(
      updatingServiceIds: updatingServiceIds ?? this.updatingServiceIds,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      lastUpdatedService: clearLastUpdated
          ? null
          : (lastUpdatedService ?? this.lastUpdatedService),
      patchedServiceId:
          clearPatch ? null : (patchedServiceId ?? this.patchedServiceId),
      patchedIsAvailable: clearPatch
          ? null
          : (patchedIsAvailable ?? this.patchedIsAvailable),
    );
  }

  @override
  List<Object?> get props => [
        updatingServiceIds,
        errorMessage,
        lastUpdatedService,
        patchedServiceId,
        patchedIsAvailable,
      ];
}
