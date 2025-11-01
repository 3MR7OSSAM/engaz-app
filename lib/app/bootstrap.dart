import 'dart:async';
import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:engaz_task/app/app_bloc_observer.dart';
import 'package:engaz_task/app/core/cubit/connectivity/connectivity_cubit.dart';
import 'package:engaz_task/app/core/injection/injection.dart';
import 'package:engaz_task/app/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:window_manager/window_manager.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  // Enable catching Flutter framework errors
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    // Log to crash reporting service if needed
  };

  // For web platform in debug mode
  if (kDebugMode) {
    PlatformDispatcher.instance.onError = (error, stack) {
      debugPrint('Uncaught platform error: $error');
      debugPrint('Stack trace: $stack');
      return true;
    };
  }

  // Run the app in a guarded zone to catch errors outside Flutter
  await runZonedGuarded(
    () async {
      // Prevent frame drops during initialization
      await _initializeApp();
      runApp(_buildAppWithProviders(await builder()));
    },
    (error, stack) {
      debugPrint('Uncaught error: $error');
      debugPrint('Stack trace: $stack');
      // Report to crash service here
    },
  );
}

Future<void> _initializeApp() async {
  // Ensure Flutter is initialized first
  WidgetsFlutterBinding.ensureInitialized();

  // Configure dependencies after preferences are loaded
  await configureDependencies();

  // Setup desktop window if needed
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await _setupDesktopWindow();
  }

  // Set up BLoC observer
  Bloc.observer = AppBlocObserver(getIt.get<Logger>());
}

/// Build the application with properly organized providers
Widget _buildAppWithProviders(Widget app) {
  // Use lazy creation for blocs that aren't needed immediately
  return MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => getIt.get<ConnectivityCubit>()),
      BlocProvider(create: (_) => getIt.get<SettingsBloc>()),
    ],
    child: app,
  );
}

/// Configure window settings for desktop platforms
Future<void> _setupDesktopWindow() async {
  await windowManager.ensureInitialized();
  const windowOptions = WindowOptions(
    size: Size(1200, 800),
    minimumSize: Size(800, 600),
    center: true,
    skipTaskbar: false,
    backgroundColor: Colors.transparent,
    titleBarStyle: TitleBarStyle.hidden,
  );

  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  doWhenWindowReady(() {
    appWindow.alignment = Alignment.center;
    appWindow
      ..maximize()
      ..show();
  });
}
