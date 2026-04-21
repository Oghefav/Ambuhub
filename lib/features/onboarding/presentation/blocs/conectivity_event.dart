abstract class ConnectivityEvent {}

class ConnectivityStartMonitoring extends ConnectivityEvent {}

class ConnectivityStatusChanged extends ConnectivityEvent {
  final bool isConnected;
  ConnectivityStatusChanged(this.isConnected);
}