// connectivity_bloc.dart
import 'dart:async';
import 'package:ambuhub/features/onboarding/presentation/blocs/conectivity_event.dart';
import 'package:ambuhub/features/onboarding/presentation/blocs/connectivity_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  StreamSubscription? _subscription;

  ConnectivityBloc() : super(ConnectivityInitial()) {
    on<ConnectivityStartMonitoring>(onConnectivityStartMonitoring);

    on<ConnectivityStatusChanged>(onConnectivityStatusChanged);
  }
  
  void onConnectivityStartMonitoring(
    ConnectivityStartMonitoring event,
    Emitter<ConnectivityState> emit,
  ) async {
    final isConnected = await InternetConnection().hasInternetAccess;
    emit(isConnected ? ConnectivityOnline() : ConnectivityOffline());

    _subscription = InternetConnection().onStatusChange.listen((status) {
      add(ConnectivityStatusChanged(status == InternetStatus.connected));
    });
  }

  void onConnectivityStatusChanged(
    ConnectivityStatusChanged event,
    Emitter<ConnectivityState> emit,
  ) {
    {
      emit(event.isConnected ? ConnectivityOnline() : ConnectivityOffline());
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
