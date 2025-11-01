part of 'connectivity_cubit.dart';

abstract class ConnectivityState {
  const ConnectivityState();
}

class ConnectivityInitial extends ConnectivityState {
  const ConnectivityInitial();
}

class ConnectivityConnected extends ConnectivityState {

  const ConnectivityConnected({
    required this.connectionType,
    required this.connectionName,
    this.speed,
  });
  final ConnectivityResult connectionType;
  final String connectionName;
  final double? speed;

  @override
  String toString() => 'Connected ($connectionName)';
}

class ConnectivityDisconnected extends ConnectivityState {

  const ConnectivityDisconnected({this.message});
  final String? message;

  @override
  String toString() => 'Disconnected${message != null ? ': $message' : ''}';
}
