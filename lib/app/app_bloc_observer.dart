import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@lazySingleton
class AppBlocObserver extends BlocObserver {
  const AppBlocObserver(this._logger);
  final Logger _logger;

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    _safeLog('✨ onCreate → ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    _safeLog('🌀 onChange → ${bloc.runtimeType}\nChange: $change');
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    _safeLog('🔄 onTransition → ${bloc.runtimeType}\n$transition');
  }

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

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    _safeLog('🧹 onClose → ${bloc.runtimeType}');
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
