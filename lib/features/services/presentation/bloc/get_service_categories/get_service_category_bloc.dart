import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/features/services/domain/usecase/get_service_categories.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_service_categories/get_service_category_event.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_service_categories/get_service_category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetServiceCategoriesBloc extends Bloc<GetServiceCategoriesEvent, GetServiceCategoriesState> {
  final GetServiceCategoriesUsecase _getServiceCategoriesUsecase;

  GetServiceCategoriesBloc(this._getServiceCategoriesUsecase) : super(const GetServiceCategoriesInitial()){
    on<GetServiceCategories>(onGetServiceCategories);
  }

  void onGetServiceCategories(GetServiceCategories event, Emitter<GetServiceCategoriesState> emit) async {
    emit(const GetServiceCategoriesLoading());
    final dataState = await _getServiceCategoriesUsecase();
    if (dataState is DataSuccess) {
      emit(GetServiceCategoriesSuccess(serviceCategories: dataState.data));
    } else {
      emit(GetServiceCategoriesError(error: dataState.errorMessage));
    }
  }

}