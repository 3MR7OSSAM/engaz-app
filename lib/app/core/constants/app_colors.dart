import 'package:flutter/material.dart';

/// App color palette matching the restaurant app design language
class AppColors {
  // Primary Brand Colors
  static const MaterialColor materialPrimary = MaterialColor(0xFFFF5722, {
    50: Color(0xFFFFEBEE),
    100: Color(0xFFFFCDD2),
    200: Color(0xFFEF9A9A),
    300: Color(0xFFE57373),
    400: Color(0xFFEF5350),
    500: Color(0xFFFF5722),
    600: Color(0xFFE64A19),
    700: Color(0xFFD84315),
    800: Color(0xFFBF360C),
    900: Color(0xFF870000),
  });

  /// Primary accent color - Deep Orange (used for headers, buttons, highlights)
  static const Color primary = Color(0xFFFF5722);

  /// Secondary accent color for ratings and highlights
  static const Color accent = Color(0xFFFFB300);

  /// Background colors
  static const Color scaffoldBackgroundColor = Color(0xFFFFFFFF);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFFDFBFF);

  /// Text colors
  static const Color textPrimary = Color(0xDD000000); // Colors.black87
  static const Color textSecondary = Color(0x99000000); // Colors.grey[600]
  static const Color textTertiary = Color(0xB3000000); // Colors.grey[700]
  static const Color textDisabled = Color(0x61000000); // Colors.grey
  static const Color textLight = Color(0x8A000000); // Colors.black54

  /// Border and divider colors
  static const Color border = Color(0xFFE0E0E0); // Colors.grey.shade300
  static const Color divider = Color(0xFFEAEAEA);

  /// Shadow color
  static const Color shadow =
      Color(0x0D000000); // Colors.black.withValues(alpha: 0.05)

  /// Status colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFB300);
  static const Color danger = Color(0xFFF44336);
  static const Color error = Color(0xFFFF0000);
  static const Color badge = Color(0xFFFF0000);

  /// Standard colors
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color transparent = Colors.transparent;
  static const Color grey = Colors.grey;

  /// Shimmer colors
  static const Color shimmerBase = Color(0xFFE0E0E0); // Colors.grey[300]
  static const Color shimmerHighlight = Color(0xFFF5F5F5); // Colors.grey[100]

  // Backward compatibility aliases
  /// @deprecated Use textDisabled instead
  @Deprecated('Use textDisabled instead')
  static const Color gray = textDisabled;

  /// @deprecated Use textSecondary instead
  @Deprecated('Use textSecondary instead')
  static const Color grayAccent = Color(0xFFE1DAD6);
}
