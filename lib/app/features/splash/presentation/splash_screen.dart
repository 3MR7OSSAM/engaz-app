import 'package:engaz_task/app/core/settings/presentation/pages/settings_page.dart';
import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const name = '/';
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
        theme: FlameSplashTheme.dark,
        controller: controller,
        showBefore: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Animated logo with glow effect
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.deepPurple.withValues(alpha: 0.3),
                      Colors.transparent,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withValues(alpha: 0.5),
                      blurRadius: 40,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.rocket_launch_rounded,
                  size: 80,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              // Game title with gradient
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [
                    Colors.deepPurple.shade300,
                    Colors.purple.shade400,
                    Colors.pink.shade300,
                  ],
                ).createShader(bounds),
                child: const Text(
                  'EPIC GAME',
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 4,
                  ),
                ),
              ),
            ],
          );
        },
        showAfter: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 32),
              // Animated loading indicator
              AnimatedBuilder(
                animation: _shimmerController,
                builder: (context, child) {
                  return Container(
                    width: 200,
                    height: 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      gradient: LinearGradient(
                        stops: [
                          _shimmerController.value - 0.3,
                          _shimmerController.value,
                          _shimmerController.value + 0.3,
                        ].map((e) => e.clamp(0.0, 1.0)).toList(),
                        colors: const [
                          Colors.white24,
                          Colors.white,
                          Colors.white24,
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              Text(
                'Loading Amazing Experience...',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withValues(alpha: 0.7),
                  letterSpacing: 1,
                ),
              ),
            ],
          );
        },
        onFinish: (context) {
          context.pushReplacement(SettingsScreen.name);
        },
      ),
    );
  }
}

// Alternative:  theme with gradient background
class ThemedSplashScreen extends StatefulWidget {
  const ThemedSplashScreen({super.key});

  @override
  State<ThemedSplashScreen> createState() => _ThemedSplashScreenState();
}

class _ThemedSplashScreenState extends State<ThemedSplashScreen> {
  late FlameSplashController controller;

  @override
  void initState() {
    super.initState();
    controller = FlameSplashController(
      fadeInDuration: const Duration(milliseconds: 1000),
      fadeOutDuration: const Duration(milliseconds: 500),
      waitDuration: const Duration(milliseconds: 2500),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlameSplashScreen(
        theme: FlameSplashTheme(
          backgroundDecoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF1a1a2e),
                Color(0xFF16213e),
                Color(0xFF0f3460),
              ],
            ),
          ),
          logoBuilder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Color(0xFFe94560), Color(0xFFff6b9d)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFe94560).withValues(alpha: 0.6),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.games_rounded,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
              ],
            );
          },
        ),
        controller: controller,
        showBefore: (context) {
          return ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFFe94560), Color(0xFFff6b9d)],
            ).createShader(bounds),
            child: const Text(
              'GAME STUDIO',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 3,
              ),
            ),
          );
        },
        showAfter: (context) {
          return const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 40),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFe94560)),
                strokeWidth: 3,
              ),
              SizedBox(height: 16),
              Text(
                'Preparing Your Adventure',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  letterSpacing: 1,
                ),
              ),
            ],
          );
        },
        onFinish: (context) {
          Navigator.pushReplacementNamed(context, '/game');
        },
      ),
    );
  }
}
