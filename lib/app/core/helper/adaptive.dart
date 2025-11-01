import 'package:flutter/material.dart';

class AdaptiveLayout extends StatelessWidget {
  const AdaptiveLayout({
    required this.mobileLayout, super.key,
    this.tabletLayout,
    this.desktopLayout,
  });

  final WidgetBuilder mobileLayout;
  final WidgetBuilder? tabletLayout;
  final WidgetBuilder? desktopLayout;

  static const double tabletBreakpoint = 800;
  static const double desktopBreakpoint = 1200;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < tabletBreakpoint) {
          // 📱 تصميم الموبايل
          return mobileLayout(context);
        }
        if (constraints.maxWidth < desktopBreakpoint) {
          return (tabletLayout ?? mobileLayout)(context);
        }
        return (desktopLayout ?? tabletLayout ?? mobileLayout)(context);
      },
    );
  }
}
