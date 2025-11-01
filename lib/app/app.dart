import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:engaz_task/app/core/constants/app_keys.dart';
import 'package:engaz_task/app/core/l10n/language.dart';
import 'package:engaz_task/app/core/routing/app_router.dart';
import 'package:engaz_task/app/core/services/theme_service.dart';
import 'package:engaz_task/app/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late Size _designSize;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _calculateDesignSize();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    // Recalculate design size only when screen metrics change
    _calculateDesignSize();
  }

  void _calculateDesignSize() {
    final view = WidgetsBinding.instance.platformDispatcher.views.first;
    final width = view.physicalSize.width / view.devicePixelRatio;
    _designSize = _getDesignSize(width);
  }

  Size _getDesignSize(double screenWidth) {
    if (screenWidth <= 600) return const Size(375, 812);
    if (screenWidth <= 1024) return const Size(768, 1024);
    return const Size(1440, 1024);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: _designSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) => const _AppWithTheme(),
    );
  }
}

// Using a separate widget improves performance by isolating rebuilds
class _AppWithTheme extends StatelessWidget {
  const _AppWithTheme();

  @override
  Widget build(BuildContext context) {
    // Use SettingsBloc as the single source of truth for theme and locale.
    return BlocBuilder<SettingsBloc, SettingsState>(
      // Rebuild only when themeMode or language changes.
      buildWhen: (previous, current) =>
          previous.settings.themeMode != current.settings.themeMode ||
          previous.settings.language != current.settings.language,
      builder: (context, settingsState) {
        final themeMode = settingsState.settings.themeMode;
        final locale = Language.english.locale;
        return _LocalizedApp(themeMode: themeMode, locale: locale);
      },
    );
  }
}

// Using a separate widget for the MaterialApp so rebuilds are scoped
class _LocalizedApp extends StatelessWidget {
  const _LocalizedApp({required this.themeMode, required this.locale});

  final ThemeMode themeMode;
  final Locale? locale;

  @override
  Widget build(BuildContext context) {
    return WindowBorder(
      color: Theme.of(context).colorScheme.surface,
      width: 1,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: AppKeys.appName,
        theme: AppTheme.lightTheme,
        routerConfig: appRouter,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeMode,
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }

}
