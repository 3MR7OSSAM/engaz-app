import 'package:engaz_task/app/features/menu/presentation/pages/manu_screen.dart';
import 'package:engaz_task/app/features/restaurants/presentation/pages/restaurants_screen.dart';
import 'package:engaz_task/app/features/splash/presentation/pages/splash_screen.dart';
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
      // ADD THIS BUILDER - it's required!
      builder: (context, state, child) {
        return Scaffold(
          body: child,
        );
      },
      routes: [
        GoRoute(
          path: '/restaurants',
          name: RestaurantsScreen.name,
          builder: (context, state) => const RestaurantsScreen(),
        ),
        GoRoute(
          path: '/menu/:vendorId/:branchId',
          name: MenuScreen.name,
          builder: (context, state) {
            // Extract path parameters and forward them to the screen
            final vendorId = state.pathParameters['vendorId'] ?? '';
            final branchId = state.pathParameters['branchId'] ?? '';
            return MenuScreen(vendorId: vendorId, branchId: branchId);
          },
        ),
      ],
    ),
  ],

  // Global fallback
  errorBuilder: (context, state) =>
      const Scaffold(body: Center(child: Text('Route not found'))),
);
