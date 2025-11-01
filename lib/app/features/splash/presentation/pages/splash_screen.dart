import 'package:engaz_task/app/core/constants/app_colors.dart';
import 'package:engaz_task/app/features/restaurants/presentation/pages/restaurants_screen.dart';
import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

part '../widgets/splash_parts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const name = 'splash';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late FlameSplashController controller;
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    controller = FlameSplashController(
      fadeInDuration: const Duration(milliseconds: 800),
      fadeOutDuration: const Duration(milliseconds: 600),
    );

    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlameSplashScreen(
        // Replace FlameSplashTheme.white with custom theme
        theme: FlameSplashTheme(
          backgroundDecoration: const BoxDecoration(
            color: Colors.white, // or any color you want
          ),
          logoBuilder: (context) {
            // This replaces the Flame logo with your custom logo
            return const _SplashLogo();
          },
        ),
        controller: controller,
        // Remove showBefore since your logo is now the main logo
        showAfter: (BuildContext context) {
          return _SplashLoadingIndicator(shimmerController: _shimmerController);
        },
        onFinish: (context) {
          context.goNamed(RestaurantsScreen.name);
        },
      ),
    );
  }
}
