import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/features/services/domain/usecase/update_service.dart';
import 'package:ambuhub/features/services/presentation/bloc/update_service/update_service_event.dart';
import 'package:ambuhub/features/services/presentation/bloc/update_service/update_service_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateServiceBloc extends Bloc<UpdateServiceEvent, UpdateServiceState> {
  final UpdateServiceUsecase _updateServiceUsecase;
  UpdateServiceBloc(this._updateServiceUsecase)
      : super(const UpdateServiceInitial()) {
    on<UpdateService>(onUpdateService);
    on<UpdateServiceReset>(onUpdateServiceReset);
  }

  void onUpdateService(
    UpdateService event,
    Emitter<UpdateServiceState> emit,
  ) async {
    emit(const UpdateServiceLoading());
    final dataState = await _updateServiceUsecase(params: event.service);
    if (dataState is DataSuccess) {
      emit(UpdateServiceSuccess(service: dataState.data));
    } else {
      emit(UpdateServiceError(errorMessage: dataState.errorMessage));
    }
  }

  void onUpdateServiceReset(
    UpdateServiceReset event,
    Emitter<UpdateServiceState> emit,
  ) {
    emit(const UpdateServiceInitial());
  }
}
