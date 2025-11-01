import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'connectivity_state.dart';

@singleton
class ConnectivityCubit extends Cubit<ConnectivityState> {

  ConnectivityCubit() : super(const ConnectivityInitial()) {
    log('ConnectivityCubit initialized');
    _startMonitoring();
  }
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  void _startMonitoring() {
    log('Starting connectivity monitoring...');
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) async {
      final result =
          results.isNotEmpty ? results.last : ConnectivityResult.none;

      log('Connectivity changed: $result');

      if (result == ConnectivityResult.none) {
        log('No connection detected (network)');
        emit(const ConnectivityDisconnected());
      } else {
        emit(
          ConnectivityConnected(
            connectionType: result,
            connectionName: _getConnectionName(result),
          ),
        );
      }
    });

    _checkCurrentConnectivity();
  }

  Future<void> _checkCurrentConnectivity() async {
    log('Checking initial connectivity...');
    final connectivityResult = await _connectivity.checkConnectivity();
    log('Initial connectivity result: $connectivityResult');

    if (connectivityResult.contains(ConnectivityResult.none) ||
        connectivityResult.isEmpty) {
      log('No network connection at start');
      emit(const ConnectivityDisconnected());
    } else {
      final result = connectivityResult.isNotEmpty
          ? connectivityResult.last
          : ConnectivityResult.none;

      emit(
        ConnectivityConnected(
          connectionType: result,
          connectionName: _getConnectionName(result),
        ),
      );
    }
  }

  // Manual check that can be called from anywhere in the app
 String _getConnectionName(ConnectivityResult result) {
  switch (result) {
    case ConnectivityResult.wifi:
      return 'WiFi';
    case ConnectivityResult.mobile:
      return 'Mobile Data';
    case ConnectivityResult.ethernet:
      return 'Ethernet';
    case ConnectivityResult.bluetooth:
      return 'Bluetooth';
    case ConnectivityResult.vpn:
      return 'VPN';
    case ConnectivityResult.other:
      return 'Other';
    case ConnectivityResult.none:
      return 'No Connection';
  }
}


  bool get isConnected => state is ConnectivityConnected;
  bool get isDisconnected => state is ConnectivityDisconnected;

  @override
  Future<void> close() {
    log('Disposing ConnectivityCubit...');
    _connectivitySubscription.cancel();
    return super.close();
  }
}
