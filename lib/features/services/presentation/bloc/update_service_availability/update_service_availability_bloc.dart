import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/features/services/domain/enitities/update_service_availability_params.dart';
import 'package:ambuhub/features/services/domain/usecase/update_service_availability.dart';
import 'package:ambuhub/features/services/presentation/bloc/update_service_availability/update_service_availability_event.dart';
import 'package:ambuhub/features/services/presentation/bloc/update_service_availability/update_service_availability_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateServiceAvailabilityBloc
    extends Bloc<UpdateServiceAvailabilityEvent, UpdateServiceAvailabilityState> {
  final UpdateServiceAvailabilityUsecase _updateServiceAvailabilityUsecase;

  UpdateServiceAvailabilityBloc(this._updateServiceAvailabilityUsecase)
      : super(const UpdateServiceAvailabilityState()) {
    on<UpdateServiceAvailability>(_onUpdateServiceAvailability);
    on<UpdateServiceAvailabilityReset>(_onReset);
  }

  Future<void> _onUpdateServiceAvailability(
    UpdateServiceAvailability event,
    Emitter<UpdateServiceAvailabilityState> emit,
  ) async {
    final updating = Set<String>.from(state.updatingServiceIds)
      ..add(event.serviceId);

    emit(state.copyWith(
      updatingServiceIds: updating,
      clearError: true,
      clearLastUpdated: true,
      clearPatch: true,
    ));

    final dataState = await _updateServiceAvailabilityUsecase(
      params: UpdateServiceAvailabilityParams(
        serviceId: event.serviceId,
        isAvailable: event.isAvailable,
      ),
    );

    final doneUpdating = Set<String>.from(state.updatingServiceIds)
      ..remove(event.serviceId);

    if (dataState is DataSuccess) {
      emit(UpdateServiceAvailabilityState(
        updatingServiceIds: doneUpdating,
        lastUpdatedService: dataState.data,
        patchedServiceId: dataState.data == null ? event.serviceId : null,
        patchedIsAvailable: dataState.data == null ? event.isAvailable : null,
      ));
      return;
    }

    emit(UpdateServiceAvailabilityState(
      updatingServiceIds: doneUpdating,
      errorMessage: dataState.errorMessage ?? 'Could not update availability',
    ));
  }

  void _onReset(
    UpdateServiceAvailabilityReset event,
    Emitter<UpdateServiceAvailabilityState> emit,
  ) {
    emit(const UpdateServiceAvailabilityState());
  }
}
