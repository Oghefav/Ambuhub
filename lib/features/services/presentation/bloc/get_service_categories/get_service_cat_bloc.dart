import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/features/services/domain/usecase/get_service_categories.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_service_categories/get_service_cat_event.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_service_categories/get_service_cat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetServiceCatBloc extends Bloc<GetServiceCatEvent, GetServiceCatState> {
  final GetServiceCategoriesUsecase _getServiceCategoriesUsecase;
  GetServiceCatBloc(this._getServiceCategoriesUsecase)
    : super(const GetServiceCatInitial()) {
    on<GetServiceCategories>(onGetServiceCategories);
  }

  void onGetServiceCategories(
    GetServiceCategories event,
    Emitter<GetServiceCatState> emit,
  ) async {
    emit(GetServiceCatLoading());
    final dataState = await _getServiceCategoriesUsecase();
    if (dataState is DataSuccess) {
      emit(GetServiceCatSuccess(categories: dataState.data));
    } else {
      emit(GetServiceCatFailure(error: dataState.errorMessage));
    }
  }
}
