import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/features/services/domain/usecase/delete_service.dart';
import 'package:ambuhub/features/services/presentation/bloc/delete_service/delete_service_event.dart';
import 'package:ambuhub/features/services/presentation/bloc/delete_service/delete_service_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteServiceBloc extends Bloc<DeleteServiceEvent, DeleteServiceState> {
  final DeleteServiceUsecase _deleteServiceUsecase;

  DeleteServiceBloc(this._deleteServiceUsecase)
      : super(const DeleteServiceInitial()) {
    on<DeleteService>(_onDeleteService);
    on<DeleteServiceReset>(_onReset);
  }

  void _onReset(DeleteServiceReset event, Emitter<DeleteServiceState> emit) {
    emit(const DeleteServiceInitial());
  }

  Future<void> _onDeleteService(
    DeleteService event,
    Emitter<DeleteServiceState> emit,
  ) async {
    emit(const DeleteServiceLoading());
    final dataState = await _deleteServiceUsecase(params: event.serviceId);

    if (dataState is DataSuccess) {
      emit(const DeleteServiceSuccess());
    } else {
      emit(DeleteServiceError(errorMessage: dataState.errorMessage));
    }
  }
}
