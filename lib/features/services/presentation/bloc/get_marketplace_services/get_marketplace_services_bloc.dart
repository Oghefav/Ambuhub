import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/domain/usecase/get_marketplace_service_by_id.dart';
import 'package:ambuhub/features/services/domain/usecase/get_marketplace_services.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_marketplace_services/get_marketplace_services_event.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_marketplace_services/get_marketplace_services_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetMarketplaceServicesBloc
    extends Bloc<GetMarketplaceServicesEvent, GetMarketplaceServicesState> {
  final GetMarketplaceServicesUsecase _getMarketplaceServicesUsecase;
  final GetMarketplaceServiceByIdUsecase _getMarketplaceServiceByIdUsecase;

  final Map<String, List<ServiceEntity>> _marketplaceCache = {};

  GetMarketplaceServicesBloc(
    this._getMarketplaceServicesUsecase,
    this._getMarketplaceServiceByIdUsecase,
  ) : super(const GetMarketplaceServicesInitial()) {
    on<GetMarketplaceServices>(_onGetMarketplaceServices);
    on<GetMarketplaceServiceById>(_onGetMarketplaceServiceById);
    on<ClearMarketplaceServiceDetail>(_onClearMarketplaceServiceDetail);
  }

  Future<void> _onGetMarketplaceServices(
    GetMarketplaceServices event,
    Emitter<GetMarketplaceServicesState> emit,
  ) async {
    final slug = event.categorySlug;
    final cached = _marketplaceCache[slug];

    if (!event.forceRefresh && cached != null) {
      emit(
        GetMarketplaceServicesSuccess(
          services: cached,
          categorySlug: slug,
          loadedService: state.loadedService,
          serviceByIdError: state.serviceByIdError,
          isLoadingServiceById: state.isLoadingServiceById,
          pendingServiceById: state.pendingServiceById,
        ),
      );
      return;
    }

    emit(
      GetMarketplaceServicesLoading(
        services: state.services,
        categorySlug: state.categorySlug,
        loadedService: state.loadedService,
        serviceByIdError: state.serviceByIdError,
        isLoadingServiceById: state.isLoadingServiceById,
        pendingServiceById: state.pendingServiceById,
      ),
    );
    final dataState = await _getMarketplaceServicesUsecase(params: slug);
    if (dataState is DataSuccess) {
      _marketplaceCache[slug] = dataState.data ?? [];
      emit(
        GetMarketplaceServicesSuccess(
          services: dataState.data,
          categorySlug: slug,
          loadedService: state.loadedService,
          serviceByIdError: state.serviceByIdError,
          isLoadingServiceById: state.isLoadingServiceById,
          pendingServiceById: state.pendingServiceById,
        ),
      );
    } else {
      emit(
        GetMarketplaceServicesFailure(
          errorMessage: dataState.errorMessage,
          services: state.services,
          categorySlug: state.categorySlug,
          loadedService: state.loadedService,
          serviceByIdError: state.serviceByIdError,
          isLoadingServiceById: state.isLoadingServiceById,
          pendingServiceById: state.pendingServiceById,
        ),
      );
    }
  }

  Future<void> _onGetMarketplaceServiceById(
    GetMarketplaceServiceById event,
    Emitter<GetMarketplaceServicesState> emit,
  ) async {
    emit(_mapState(
      clearLoadedService: true,
      clearServiceByIdError: true,
      isLoadingServiceById: true,
      pendingServiceById: event.serviceId,
    ));

    final dataState =
        await _getMarketplaceServiceByIdUsecase(params: event.serviceId);
    if (dataState is DataSuccess && dataState.data != null) {
      emit(_mapState(
        loadedService: dataState.data,
        clearServiceByIdError: true,
        isLoadingServiceById: false,
        clearPendingServiceById: true,
      ));
      return;
    }

    emit(_mapState(
      clearLoadedService: true,
      serviceByIdError: dataState.errorMessage ?? 'Failed to load service',
      isLoadingServiceById: false,
      clearPendingServiceById: true,
    ));
  }

  void _onClearMarketplaceServiceDetail(
    ClearMarketplaceServiceDetail event,
    Emitter<GetMarketplaceServicesState> emit,
  ) {
    emit(_mapState(
      clearLoadedService: true,
      clearServiceByIdError: true,
      isLoadingServiceById: false,
      clearPendingServiceById: true,
    ));
  }

  GetMarketplaceServicesState _mapState({
    List<ServiceEntity>? services,
    String? errorMessage,
    String? categorySlug,
    ServiceEntity? loadedService,
    String? serviceByIdError,
    bool? isLoadingServiceById,
    String? pendingServiceById,
    bool clearLoadedService = false,
    bool clearServiceByIdError = false,
    bool clearPendingServiceById = false,
  }) {
    final nextServices = services ?? state.services;
    final nextCategorySlug = categorySlug ?? state.categorySlug;
    final nextErrorMessage = errorMessage ?? state.errorMessage;
    final nextLoadedService =
        clearLoadedService ? null : (loadedService ?? state.loadedService);
    final nextServiceByIdError = clearServiceByIdError
        ? null
        : (serviceByIdError ?? state.serviceByIdError);
    final nextIsLoadingServiceById =
        isLoadingServiceById ?? state.isLoadingServiceById;
    final nextPendingServiceById = clearPendingServiceById
        ? null
        : (pendingServiceById ?? state.pendingServiceById);

    if (state is GetMarketplaceServicesSuccess) {
      return GetMarketplaceServicesSuccess(
        services: nextServices ?? state.services!,
        categorySlug: nextCategorySlug ?? state.categorySlug!,
        loadedService: nextLoadedService,
        serviceByIdError: nextServiceByIdError,
        isLoadingServiceById: nextIsLoadingServiceById,
        pendingServiceById: nextPendingServiceById,
      );
    }
    if (state is GetMarketplaceServicesFailure) {
      return GetMarketplaceServicesFailure(
        errorMessage: nextErrorMessage ?? state.errorMessage,
        services: nextServices,
        categorySlug: nextCategorySlug,
        loadedService: nextLoadedService,
        serviceByIdError: nextServiceByIdError,
        isLoadingServiceById: nextIsLoadingServiceById,
        pendingServiceById: nextPendingServiceById,
      );
    }
    if (state is GetMarketplaceServicesLoading) {
      return GetMarketplaceServicesLoading(
        services: nextServices,
        categorySlug: nextCategorySlug,
        loadedService: nextLoadedService,
        serviceByIdError: nextServiceByIdError,
        isLoadingServiceById: nextIsLoadingServiceById,
        pendingServiceById: nextPendingServiceById,
      );
    }
    return GetMarketplaceServicesInitial(
      loadedService: nextLoadedService,
      serviceByIdError: nextServiceByIdError,
      isLoadingServiceById: nextIsLoadingServiceById,
      pendingServiceById: nextPendingServiceById,
    );
  }

  void invalidateMarketplaceCache([String? categorySlug]) {
    if (categorySlug != null) {
      _marketplaceCache.remove(categorySlug);
    } else {
      _marketplaceCache.clear();
    }
  }
}
