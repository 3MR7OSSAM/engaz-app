part of '../pages/splash_screen.dart';

class _SplashLoadingIndicator extends StatefulWidget {
  const _SplashLoadingIndicator({
    required this.shimmerController,
  });

  final AnimationController shimmerController;

  @override
  State<_SplashLoadingIndicator> createState() =>
      _SplashLoadingIndicatorState();
}

class _SplashLoadingIndicatorState extends State<_SplashLoadingIndicator> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 32),
        AnimatedBuilder(
          animation: widget.shimmerController,
          builder: (context, child) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                gradient: LinearGradient(
                  stops: [
                    widget.shimmerController.value - 0.3,
                    widget.shimmerController.value,
                    widget.shimmerController.value + 0.3,
                  ].map((e) => e.clamp(0.0, 1.0)).toList(),
                  colors: [
                    AppColors.primary.withValues(alpha: 0.7),
                    AppColors.primary,
                    AppColors.primary.withValues(alpha: 0.26),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        Text(
          'Getting Things Ready...',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.primary.withValues(alpha: 0.7),
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}

class _SplashLogo extends StatelessWidget {
  const _SplashLogo();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Animated logo with glow effect
        Container(
          padding: const EdgeInsets.all(24),
          child:  Image(
            image: const AssetImage('assets/logos/engaz.jpg'),
            width: 200.w,
            height: 200.h,
          ),
        ),
        const SizedBox(height: 24),
        // Game title with gradient
        Text(
            'Welcome To Engaz',
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w900,
              color: AppColors.primary,
              letterSpacing: 4,
            ),
          ),
      ],
    );
  }
}
