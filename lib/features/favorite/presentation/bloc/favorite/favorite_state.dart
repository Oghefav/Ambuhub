import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:equatable/equatable.dart';

abstract class FavoriteState extends Equatable {
  final Set<String> favoriteServiceIds;
  final List<ServiceEntity> services;
  final String? errorMessage;
  final String? pendingServiceId;
  final bool hasLoaded;
  final String? lastAddedServiceId;

  const FavoriteState({
    this.favoriteServiceIds = const {},
    this.services = const [],
    this.errorMessage,
    this.pendingServiceId,
    this.hasLoaded = false,
    this.lastAddedServiceId,
  });

  bool isFavorite(String serviceId) => favoriteServiceIds.contains(serviceId);

  bool get isInitialLoad => !hasLoaded;

  @override
  List<Object?> get props => [
        favoriteServiceIds,
        services,
        errorMessage,
        pendingServiceId,
        hasLoaded,
        lastAddedServiceId,
      ];
}

class FavoriteInitial extends FavoriteState {
  const FavoriteInitial();
}

class FavoriteLoading extends FavoriteState {
  const FavoriteLoading({
    super.favoriteServiceIds,
    super.services,
    super.pendingServiceId,
    super.hasLoaded,
    super.lastAddedServiceId,
  });
}

class FavoriteSuccess extends FavoriteState {
  const FavoriteSuccess({
    required super.favoriteServiceIds,
    super.services,
    super.pendingServiceId,
    super.hasLoaded = true,
    super.lastAddedServiceId,
  });
}

class FavoriteFailure extends FavoriteState {
  const FavoriteFailure({
    required super.errorMessage,
    super.favoriteServiceIds,
    super.services,
    super.hasLoaded,
    super.pendingServiceId,
  });
}
