import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@lazySingleton
class AppBlocObserver extends BlocObserver {
  const AppBlocObserver(this._logger);
  final Logger _logger;
  @override
  void onError(
    BlocBase<dynamic> bloc,
    Object error,
    StackTrace stackTrace,
  ) {
    _safeLog(
      '💥 onError → ${bloc.runtimeType}',
      isError: true,
      error: error,
      stackTrace: stackTrace,
    );
    super.onError(bloc, error, stackTrace);
  }

  void _safeLog(
    String message, {
    bool isError = false,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (kReleaseMode) return;
    if (isError) {
      _logger.e(message, error: error, stackTrace: stackTrace);
    } else {
      _logger.i(message);
    }
  }
}
