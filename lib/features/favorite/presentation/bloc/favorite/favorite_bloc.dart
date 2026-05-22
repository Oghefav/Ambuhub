import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/features/favorite/domain/usecases/add_favorite.dart';
import 'package:ambuhub/features/favorite/domain/usecases/get_favorites.dart';
import 'package:ambuhub/features/favorite/domain/usecases/remove_favorite.dart';
import 'package:ambuhub/features/favorite/presentation/bloc/favorite/favorite_event.dart';
import 'package:ambuhub/features/favorite/presentation/bloc/favorite/favorite_state.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final GetFavoritesUsecase _getFavoritesUsecase;
  final AddFavoriteUsecase _addFavoriteUsecase;
  final RemoveFavoriteUsecase _removeFavoriteUsecase;

  FavoriteBloc(
    this._getFavoritesUsecase,
    this._addFavoriteUsecase,
    this._removeFavoriteUsecase,
  ) : super(const FavoriteInitial()) {
    on<GetFavorites>(_onGetFavorites);
    on<AddFavorite>(_onAddFavorite);
    on<RemoveFavorite>(_onRemoveFavorite);
    on<ToggleFavorite>(_onToggleFavorite);
    on<FavoriteReset>(_onReset);
  }

  void _onReset(FavoriteReset event, Emitter<FavoriteState> emit) {
    emit(const FavoriteInitial());
  }

  Future<void> _onGetFavorites(
    GetFavorites event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(FavoriteLoading(
      favoriteServiceIds: state.favoriteServiceIds,
      services: state.services,
      hasLoaded: state.hasLoaded,
    ));
    final dataState = await _getFavoritesUsecase();
    _emitFromDataState(dataState, emit);
  }

  Future<void> _onAddFavorite(
    AddFavorite event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(FavoriteLoading(
      favoriteServiceIds: state.favoriteServiceIds,
      services: state.services,
      pendingServiceId: event.serviceId,
      hasLoaded: state.hasLoaded,
    ));
    final dataState = await _addFavoriteUsecase(params: event.serviceId);
    if (dataState is DataSuccess) {
      _emitFromDataState(
        dataState,
        emit,
        fallbackIds: _idsWith(event.serviceId!),
        pendingServiceId: null,
        lastAddedServiceId: event.serviceId,
      );
      return;
    }
    emit(FavoriteFailure(
      errorMessage: dataState.errorMessage,
      favoriteServiceIds: state.favoriteServiceIds,
      services: state.services,
      hasLoaded: state.hasLoaded,
    ));
  }

  Future<void> _onRemoveFavorite(
    RemoveFavorite event,
    Emitter<FavoriteState> emit,
  ) async {
    final serviceId = event.serviceId!;
    final previousServices = List<ServiceEntity>.from(state.services);
    final previousIds = Set<String>.from(state.favoriteServiceIds);

    final optimisticServices =
        previousServices.where((s) => s.id != serviceId).toList();
    final optimisticIds = _idsWithout(serviceId);

    emit(FavoriteSuccess(
      favoriteServiceIds: optimisticIds,
      services: optimisticServices,
      hasLoaded: true,
    ));

    final dataState = await _removeFavoriteUsecase(params: serviceId);
    if (dataState is DataSuccess) {
      final services = dataState.data ?? [];
      emit(FavoriteSuccess(
        favoriteServiceIds: services.isNotEmpty
            ? services.map((s) => s.id).toSet()
            : optimisticIds,
        services: services.isNotEmpty ? services : optimisticServices,
        hasLoaded: true,
      ));
      return;
    }

    emit(FavoriteSuccess(
      favoriteServiceIds: previousIds,
      services: previousServices,
      hasLoaded: true,
    ));
  }

  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<FavoriteState> emit,
  ) async {
    final serviceId = event.serviceId!;

    if (!state.hasLoaded) {
      emit(FavoriteLoading(
        favoriteServiceIds: state.favoriteServiceIds,
        services: state.services,
        pendingServiceId: serviceId,
      ));
      final dataState = await _getFavoritesUsecase();
      if (dataState is! DataSuccess) {
        emit(FavoriteFailure(
          errorMessage: dataState.errorMessage,
          favoriteServiceIds: state.favoriteServiceIds,
          services: state.services,
        ));
        return;
      }
      _emitFromDataState(dataState, emit, pendingServiceId: serviceId);
    }

    if (state.isFavorite(serviceId)) {
      await _onRemoveFavorite(RemoveFavorite(serviceId: serviceId), emit);
    } else {
      await _onAddFavorite(AddFavorite(serviceId: serviceId), emit);
    }
  }

  void _emitFromDataState(
    DataState<List<ServiceEntity>> dataState,
    Emitter<FavoriteState> emit, {
    Set<String>? fallbackIds,
    String? pendingServiceId,
    String? lastAddedServiceId,
  }) {
    if (dataState is DataSuccess) {
      final services = dataState.data ?? [];
      final ids = services.isNotEmpty
          ? services.map((s) => s.id).toSet()
          : (fallbackIds ?? state.favoriteServiceIds);
      emit(FavoriteSuccess(
        favoriteServiceIds: ids,
        services: services.isNotEmpty ? services : state.services,
        pendingServiceId: pendingServiceId,
        lastAddedServiceId: lastAddedServiceId,
      ));
      return;
    }
    emit(FavoriteFailure(
      errorMessage: dataState.errorMessage,
      favoriteServiceIds: state.favoriteServiceIds,
      services: state.services,
      hasLoaded: state.hasLoaded,
    ));
  }

  Set<String> _idsWithout(String serviceId) {
    return Set<String>.from(state.favoriteServiceIds)..remove(serviceId);
  }

  Set<String> _idsWith(String serviceId) {
    return Set<String>.from(state.favoriteServiceIds)..add(serviceId);
  }
}
