import 'package:engaz_task/app/core/settings/presentation/pages/settings_page.dart';
import 'package:engaz_task/app/core/widgets/shared_widgets/main_shell_layout.dart';
import 'package:engaz_task/app/features/splash/presentation/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Global key for the shell navigator
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // Splash screen - outside shell
    GoRoute(
      path: '/',
      name: SplashScreen.name,
      builder: (context, state) => const SplashScreen(),
    ),

    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        var title = 'engaz_task';
        switch (state.matchedLocation) {
          case '/settings':
            title = 'Settings';
          default:
            title = 'engaz_task';
        }

        return MainShellLayout(title: title, child: child);
      },
      routes: [
        GoRoute(
          path: '/settings',
          name: SettingsScreen.name,
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
  ],

  // Global fallback
  errorBuilder: (context, state) =>
      const Scaffold(body: Center(child: Text('Route not found'))),
);
