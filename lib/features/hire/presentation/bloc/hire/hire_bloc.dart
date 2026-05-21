import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/features/hire/domain/usecases/place_hire.dart';
import 'package:ambuhub/features/hire/presentation/bloc/hire/hire_event.dart';
import 'package:ambuhub/features/hire/presentation/bloc/hire/hire_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HireBloc extends Bloc<HireEvent, HireState> {
  final PlaceHireUsecase _placeHireUsecase;

  HireBloc(this._placeHireUsecase) : super(const HireInitial()) {
    on<PlaceHire>(_onPlaceHire);
    on<HireReset>(_onHireReset);
  }

  Future<void> _onPlaceHire(PlaceHire event, Emitter<HireState> emit) async {
    emit(const HireLoading());
    final dataState = await _placeHireUsecase(params: event.params);

    if (dataState is DataSuccess) {
      emit(HireSuccess(order: dataState.data!));
    } else {
      emit(HireFailure(errorMessage: dataState.errorMessage));
    }
  }

  void _onHireReset(HireReset event, Emitter<HireState> emit) {
    emit(const HireInitial());
  }
}
