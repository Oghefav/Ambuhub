import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/features/services/domain/usecase/add_service.dart';
import 'package:ambuhub/features/services/presentation/bloc/add_service/add_service_event.dart';
import 'package:ambuhub/features/services/presentation/bloc/add_service/add_service_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddServiceBloc extends Bloc<AddServiceEvent, AddServiceState> {
  final AddServiceUsecase _addServiceUsecase;
  AddServiceBloc(this._addServiceUsecase) : super(const AddServiceInitial()) {
    on<AddService>(onAddService);
    on<AddServiceReset>(onAddServiceReset);
  }

  void onAddService(AddService event, Emitter<AddServiceState> emit) async {
    emit(const AddServiceLoading());
    final dataState = await _addServiceUsecase(params: event.service);

    if (dataState is DataSuccess) {
      emit(AddServiceSuccess(service: dataState.data));
    } else {
      emit(AddServiceError(errorMessage: dataState.errorMessage));
    }
  }

  void onAddServiceReset(AddServiceReset event, Emitter<AddServiceState> emit) {
    emit(const AddServiceInitial());
  }
}
