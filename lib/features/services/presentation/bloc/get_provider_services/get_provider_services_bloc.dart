import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/features/services/data/model/service.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/domain/usecase/get_provider_services.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_provider_services/get_provider_services_event.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_provider_services/get_provider_services_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetProviderServicesBloc
    extends Bloc<GetProviderServicesEvent, GetProviderServicesState> {
  final GetProviderServicesUsecase _getProviderServicesUsecase;

  List<ServiceEntity>? _providerListingsCache;

  GetProviderServicesBloc(this._getProviderServicesUsecase)
    : super(const GetProviderServicesInitial()) {
    on<GetProviderServices>(_onGetProviderServices);
  }

  Future<void> _onGetProviderServices(
    GetProviderServices event,
    Emitter<GetProviderServicesState> emit,
  ) async {
    if (!event.forceRefresh && _providerListingsCache != null) {
      emit(GetProviderServicesSuccess(services: _providerListingsCache));
      return;
    }

    emit(const GetProviderServicesLoading());
    final dataState = await _getProviderServicesUsecase();
    if (dataState is DataSuccess) {
      _providerListingsCache = dataState.data;
      emit(GetProviderServicesSuccess(services: dataState.data));
    } else {
      emit(GetProviderServicesFailure(errorMessage: dataState.errorMessage));
    }
  }

  /// Call after add/update/delete so the next listings visit refetches.
  void invalidateProviderListings() => _providerListingsCache = null;

  /// Merges [updated] into the cached list and re-emits when already loaded.
  void patchService(ServiceEntity updated) {
    if (_providerListingsCache == null) return;
    _providerListingsCache = _providerListingsCache!
        .map((s) => s.id == updated.id ? updated : s)
        .toList();
    add(const GetProviderServices());
  }

  void patchServiceAvailability(String serviceId, bool isAvailable) {
    if (_providerListingsCache == null) return;
    _providerListingsCache = _providerListingsCache!.map((s) {
      if (s.id != serviceId) return s;
      return ServiceModel(
        id: s.id,
        dept: s.dept,
        description: s.description,
        photoUrls: s.photoUrls,
        serviceCategory: s.serviceCategory,
        title: s.title,
        listingType: s.listingType,
        stock: s.stock,
        price: s.price,
        available: isAvailable,
        pricePeriod: s.pricePeriod,
        country: s.country,
        stateProvince: s.stateProvince,
        stateProvinceName: s.stateProvinceName,
        officeAddress: s.officeAddress,
        hireReturnWindow: s.hireReturnWindow,
        bookingWindow: s.bookingWindow,
        bookingGapMinutes: s.bookingGapMinutes,
        createdAt: s.createdAt,
        updatedAt: s.updatedAt,
      );
    }).toList();
    add(const GetProviderServices());
  }
}
