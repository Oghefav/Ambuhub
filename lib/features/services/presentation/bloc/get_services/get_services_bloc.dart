import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/features/services/domain/usecase/get_service_info.dart';
import 'package:ambuhub/features/services/domain/usecase/get_services.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_services/get_services_event.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_services/get_services_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetServicesBloc extends Bloc<GetServicesEvent, GetServicesState> {
  final GetServicesUsecase _getServicesUsecase;
  final GetServiceInfoUsecase _getServiceInfoUsecase;
  GetServicesBloc(this._getServicesUsecase, this._getServiceInfoUsecase) : super(GetServicesInitial()) {
    on<GetServices>(onGetServices);
    on<GetServiceInfo>(onGetServiceDetails);
  }

  void onGetServices(GetServices event, Emitter<GetServicesState> emit) async {
    emit(GetServicesLoading());
    final dataState = await _getServicesUsecase();
    if (dataState is DataSuccess) {
      emit(GetServicesSuccess(services: dataState.data));
    } else {
      emit(GetServicesFailure(errorMessage: dataState.errorMessage));
    }
  }

  void onGetServiceDetails(GetServiceInfo event, Emitter<GetServicesState> emit) async {
    emit(GetServicesLoading());
    final dataState = await _getServiceInfoUsecase(params: event.categorySlug);
    if (dataState is DataSuccess) {
      emit(GetServicesSuccess(services: dataState.data));
    } else {
      emit(GetServicesFailure(errorMessage: dataState.errorMessage));
    }
  }
}
