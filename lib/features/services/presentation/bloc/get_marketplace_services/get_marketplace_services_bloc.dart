import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/domain/usecase/get_marketplace_services.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_marketplace_services/get_marketplace_services_event.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_marketplace_services/get_marketplace_services_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetMarketplaceServicesBloc
    extends Bloc<GetMarketplaceServicesEvent, GetMarketplaceServicesState> {
  final GetMarketplaceServicesUsecase _getMarketplaceServicesUsecase;

  final Map<String, List<ServiceEntity>> _marketplaceCache = {};

  GetMarketplaceServicesBloc(this._getMarketplaceServicesUsecase)
    : super(const GetMarketplaceServicesInitial()) {
    on<GetMarketplaceServices>(_onGetMarketplaceServices);
  }

  Future<void> _onGetMarketplaceServices(
    GetMarketplaceServices event,
    Emitter<GetMarketplaceServicesState> emit,
  ) async {
    final slug = event.categorySlug;
    final cached = _marketplaceCache[slug];

    if (!event.forceRefresh && cached != null) {
      emit(
        GetMarketplaceServicesSuccess(services: cached, categorySlug: slug),
      );
      return;
    }

    emit(const GetMarketplaceServicesLoading());
    final dataState = await _getMarketplaceServicesUsecase(params: slug);
    if (dataState is DataSuccess) {
      _marketplaceCache[slug] = dataState.data ?? [];
      emit(
        GetMarketplaceServicesSuccess(
          services: dataState.data,
          categorySlug: slug,
        ),
      );
    } else {
      emit(
        GetMarketplaceServicesFailure(errorMessage: dataState.errorMessage),
      );
    }
  }

  void invalidateMarketplaceCache([String? categorySlug]) {
    if (categorySlug != null) {
      _marketplaceCache.remove(categorySlug);
    } else {
      _marketplaceCache.clear();
    }
  }
}
