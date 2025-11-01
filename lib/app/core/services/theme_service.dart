import 'package:engaz_task/app/core/constants/app_colors.dart';
import 'package:engaz_task/app/core/helper/responsive_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Application theme configuration aligned with the restaurant app design
class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.white,
      fontFamily: 'Switzer',

      // Color scheme
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surfaceContainer: AppColors.surfaceLight,
        error: AppColors.error,
        onSecondary: AppColors.white,
        onSurface: AppColors.textPrimary,
        outline: AppColors.border,
        shadow: AppColors.shadow,
      ),

      // AppBar theme
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        iconTheme: const IconThemeData(color: AppColors.white),
        titleTextStyle: TextStyle(
          color: AppColors.white,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          fontFamily: 'Switzer',
        ),
        actionsIconTheme: const IconThemeData(color: AppColors.white),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),

      // Card theme
      cardTheme: CardTheme(
        color: AppColors.cardBackground,
        elevation: 2,
        shadowColor: AppColors.shadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        hintStyle: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 14.sp,
        ),
        prefixIconColor: AppColors.textSecondary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      ),

      // Divider theme
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
      ),

      // Tab bar theme
      tabBarTheme: TabBarTheme(
        labelColor: AppColors.textPrimary,
        unselectedLabelColor: AppColors.textDisabled,
        indicatorColor: AppColors.textPrimary,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: AppColors.divider,
        labelStyle: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
          fontFamily: 'Switzer',
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w400,
          fontFamily: 'Switzer',
        ),
      ),

      // Chip theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.white,
        selectedColor: AppColors.primary.withValues(alpha: 0.1),
        disabledColor: AppColors.border,
        labelStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
        secondaryLabelStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.primary,
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        side: const BorderSide(color: AppColors.border),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),

      // Button themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.white,
          backgroundColor: AppColors.primary,
          textStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Switzer',
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 2,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'Switzer',
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'Switzer',
          ),
        ),
      ),

      // Icon theme
      iconTheme: const IconThemeData(
        color: AppColors.textPrimary,
        size: 24,
      ),

      // Radio theme
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return AppColors.textSecondary;
        }),
      ),

      // Switch theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.white;
          }
          return AppColors.textSecondary;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return AppColors.border;
        }),
        trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      ),

      // Date picker theme
      datePickerTheme: DatePickerThemeData(
        backgroundColor: AppColors.white,
        headerBackgroundColor: AppColors.primary,
        headerForegroundColor: AppColors.white,
        dayForegroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.white;
          }
          return AppColors.textPrimary;
        }),
        dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return Colors.transparent;
        }),
        todayForegroundColor: WidgetStateProperty.all(AppColors.primary),
        todayBackgroundColor: WidgetStateProperty.all(
          AppColors.primary.withValues(alpha: 0.1),
        ),
      ),

      // Text theme
      textTheme: TextTheme(
        // Display styles - Large headings
        displayLarge: textStyle(
          responsiveFontSize(28, 26, 24),
          FontWeight.bold,
          AppColors.textPrimary,
        ),
        displayMedium: textStyle(
          responsiveFontSize(24, 22, 20),
          FontWeight.bold,
          AppColors.textPrimary,
        ),
        displaySmall: textStyle(
          responsiveFontSize(20, 18, 16),
          FontWeight.w600,
          AppColors.textPrimary,
        ),

        // Headline styles - Section headings
        headlineLarge: textStyle(
          responsiveFontSize(22, 20, 18),
          FontWeight.bold,
          AppColors.textPrimary,
        ),
        headlineMedium: textStyle(
          responsiveFontSize(18, 17, 16),
          FontWeight.w700,
          AppColors.textPrimary,
        ),
        headlineSmall: textStyle(
          responsiveFontSize(16, 15, 14),
          FontWeight.w600,
          AppColors.textPrimary,
        ),

        // Title styles - Card titles, list items
        titleLarge: textStyle(
          responsiveFontSize(16, 15, 14),
          FontWeight.w600,
          AppColors.textPrimary,
        ),
        titleMedium: textStyle(
          responsiveFontSize(14, 13, 12.5),
          FontWeight.w600,
          AppColors.textPrimary,
        ),
        titleSmall: textStyle(
          responsiveFontSize(13, 12.5, 12),
          FontWeight.w600,
          AppColors.textPrimary,
        ),

        // Body styles - Main content text
        bodyLarge: textStyle(
          responsiveFontSize(16, 14, 13),
          FontWeight.normal,
          AppColors.textPrimary,
        ),
        bodyMedium: textStyle(
          responsiveFontSize(14, 13, 12),
          FontWeight.normal,
          AppColors.textSecondary,
        ),
        bodySmall: textStyle(
          responsiveFontSize(12, 11, 10),
          FontWeight.normal,
          AppColors.textSecondary,
        ),

        // Label styles - Buttons, chips, small labels
        labelLarge: textStyle(
          responsiveFontSize(14, 13, 12),
          FontWeight.w500,
          AppColors.textPrimary,
        ),
        labelMedium: textStyle(
          responsiveFontSize(12, 11.5, 11),
          FontWeight.w500,
          AppColors.textSecondary,
        ),
        labelSmall: textStyle(
          responsiveFontSize(11, 10, 9),
          FontWeight.w500,
          AppColors.textTertiary,
        ),
      ),
    );
  }

  // Dark theme configuration
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: const Color(0xFF121212),
      fontFamily: 'Switzer',

      // Color scheme for dark mode
      colorScheme: ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: const Color(0xFF1E1E1E),
        surfaceContainer: const Color(0xFF2C2C2C),
        error: AppColors.error,
        onPrimary: AppColors.white,
        onSecondary: AppColors.white,
        onSurface: Colors.white.withValues(alpha: 0.87),
        onError: AppColors.white,
        outline: Colors.white.withValues(alpha: 0.12),
        shadow: Colors.black.withValues(alpha: 0.3),
      ),

      // AppBar theme for dark mode
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        iconTheme: const IconThemeData(color: AppColors.white),
        titleTextStyle: TextStyle(
          color: AppColors.white,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          fontFamily: 'Switzer',
        ),
        actionsIconTheme: const IconThemeData(color: AppColors.white),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),

      // Card theme for dark mode
      cardTheme: CardTheme(
        color: const Color(0xFF1E1E1E),
        elevation: 4,
        shadowColor: Colors.black.withValues(alpha: 0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),

      // Input decoration for dark mode
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF2C2C2C),
        hintStyle: TextStyle(
          color: Colors.white.withValues(alpha: 0.6),
          fontSize: 14.sp,
        ),
        prefixIconColor: Colors.white.withValues(alpha: 0.6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.12)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.12)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      ),

      // Button themes for dark mode
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.white,
          backgroundColor: AppColors.primary,
          textStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Switzer',
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 2,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'Switzer',
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),

      // Icon theme for dark mode
      iconTheme: IconThemeData(
        color: Colors.white.withValues(alpha: 0.87),
        size: 24,
      ),

      // Text theme for dark mode
      textTheme: TextTheme(
        displayLarge: textStyle(
          responsiveFontSize(28, 26, 24),
          FontWeight.bold,
          Colors.white.withValues(alpha: 0.87),
        ),
        displayMedium: textStyle(
          responsiveFontSize(24, 22, 20),
          FontWeight.bold,
          Colors.white.withValues(alpha: 0.87),
        ),
        displaySmall: textStyle(
          responsiveFontSize(20, 18, 16),
          FontWeight.w600,
          Colors.white.withValues(alpha: 0.87),
        ),
        headlineLarge: textStyle(
          responsiveFontSize(22, 20, 18),
          FontWeight.bold,
          Colors.white.withValues(alpha: 0.87),
        ),
        headlineMedium: textStyle(
          responsiveFontSize(18, 17, 16),
          FontWeight.w700,
          Colors.white.withValues(alpha: 0.87),
        ),
        headlineSmall: textStyle(
          responsiveFontSize(16, 15, 14),
          FontWeight.w600,
          Colors.white.withValues(alpha: 0.87),
        ),
        titleLarge: textStyle(
          responsiveFontSize(16, 15, 14),
          FontWeight.w600,
          Colors.white.withValues(alpha: 0.87),
        ),
        titleMedium: textStyle(
          responsiveFontSize(14, 13, 12.5),
          FontWeight.w600,
          Colors.white.withValues(alpha: 0.87),
        ),
        titleSmall: textStyle(
          responsiveFontSize(13, 12.5, 12),
          FontWeight.w600,
          Colors.white.withValues(alpha: 0.87),
        ),
        bodyLarge: textStyle(
          responsiveFontSize(16, 14, 13),
          FontWeight.normal,
          Colors.white.withValues(alpha: 0.87),
        ),
        bodyMedium: textStyle(
          responsiveFontSize(14, 13, 12),
          FontWeight.normal,
          Colors.white.withValues(alpha: 0.6),
        ),
        bodySmall: textStyle(
          responsiveFontSize(12, 11, 10),
          FontWeight.normal,
          Colors.white.withValues(alpha: 0.6),
        ),
        labelLarge: textStyle(
          responsiveFontSize(14, 13, 12),
          FontWeight.w500,
          Colors.white.withValues(alpha: 0.87),
        ),
        labelMedium: textStyle(
          responsiveFontSize(12, 11.5, 11),
          FontWeight.w500,
          Colors.white.withValues(alpha: 0.6),
        ),
        labelSmall: textStyle(
          responsiveFontSize(11, 10, 9),
          FontWeight.w500,
          Colors.white.withValues(alpha: 0.6),
        ),
      ),
    );
  }

  /// Helper method to create TextStyle with consistent font family
  static TextStyle textStyle(double size, FontWeight weight, Color color) {
    return TextStyle(
      fontSize: size,
      fontWeight: weight,
      color: color,
      fontFamily: 'Switzer',
    );
  }
}
