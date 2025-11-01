import 'package:engaz_task/app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppThemes {
  static ThemeData themeEnglish = ThemeData(
    fontFamily: 'Switzer',
    primaryColor: AppColors.materialPrimary,
    scaffoldBackgroundColor: AppColors.white,
    splashColor: AppColors.materialPrimary.shade200,
    canvasColor: AppColors.white,
    iconTheme: const IconThemeData(color: AppColors.primary),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: AppColors.materialPrimary,
      backgroundColor: AppColors.white,
    ),
    appBarTheme: AppBarTheme(
      color: AppColors.white,
      iconTheme: const IconThemeData(color: AppColors.primary),
      elevation: 2,
      scrolledUnderElevation: 0,
      titleSpacing: 1,
      systemOverlayStyle: SystemUiOverlayStyle(
        systemNavigationBarColor:
            SystemUiOverlayStyle.dark.systemNavigationBarColor,
        statusBarColor: AppColors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    indicatorColor: AppColors.materialPrimary.shade600,
    popupMenuTheme: PopupMenuThemeData(
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: 30.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.primary,
      ),
      headlineMedium: TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.materialPrimary.shade800,
      ),
      headlineSmall: TextStyle(
        fontSize: 26.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.primary,
      ),
      titleLarge: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
      ),
      // AppBar
      titleMedium: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.primary,
      ),
      // TextField
      titleSmall: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.materialPrimary.shade700,
      ),
      bodyLarge: TextStyle(
        fontSize: 18.sp,
        color: AppColors.primary,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: TextStyle(
        fontSize: 16.sp,
        color: AppColors.black,
        fontWeight: FontWeight.w600,
      ),
      // Text, NavBarItems
      bodySmall: TextStyle(
        fontSize: 16.sp,
        color: AppColors.primary,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: TextStyle(
        fontSize: 24.sp,
        color: AppColors.white,
        fontWeight: FontWeight.w700,
      ),
      // Button
      labelMedium: TextStyle(
        fontSize: 16.sp,
        color: AppColors.materialPrimary.shade600,
        fontWeight: FontWeight.w900,
      ),
      labelSmall: TextStyle(
        fontSize: 14.sp,
        color: AppColors.materialPrimary.shade600,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
  static ThemeData themeArabic = ThemeData(
    fontFamily: 'Switzer',
    primaryColor: AppColors.materialPrimary,
    scaffoldBackgroundColor: AppColors.white,
    splashColor: AppColors.materialPrimary.shade200,
    canvasColor: AppColors.white,
    iconTheme: const IconThemeData(color: AppColors.primary),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: AppColors.materialPrimary,
      backgroundColor: AppColors.materialPrimary.shade50,
    ),
    appBarTheme: const AppBarTheme(
      color: AppColors.white,
      iconTheme: IconThemeData(color: AppColors.primary),
      elevation: 2,
      scrolledUnderElevation: 0,
      titleSpacing: 1,
    ),
    indicatorColor: AppColors.materialPrimary.shade600,
    popupMenuTheme: PopupMenuThemeData(
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.materialPrimary.shade800,
      ),
      headlineMedium: TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.materialPrimary.shade800,
      ),
      headlineSmall: TextStyle(
        fontSize: 26.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.primary,
      ),
      titleLarge: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.primary,
      ),
      // AppBar
      titleMedium: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.primary,
      ),
      // TextField
      titleSmall: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.materialPrimary.shade700,
      ),
      bodyLarge: TextStyle(
        fontSize: 18.sp,
        color: AppColors.primary,
        fontWeight: FontWeight.w700,
      ),
      bodyMedium: TextStyle(
        fontSize: 16.sp,
        color: AppColors.primary,
        fontWeight: FontWeight.w700,
      ),
      // Text, NavBarItems
      bodySmall: TextStyle(
        fontSize: 16.sp,
        color: AppColors.primary,
        fontWeight: FontWeight.w800,
      ),
      labelLarge: TextStyle(
        fontSize: 18.sp,
        color: AppColors.materialPrimary.shade600,
        fontWeight: FontWeight.w800,
      ),
      // Button
      labelMedium: TextStyle(
        fontSize: 16.sp,
        color: AppColors.materialPrimary.shade600,
        fontWeight: FontWeight.w900,
      ),
      labelSmall: TextStyle(
        fontSize: 14.sp,
        color: AppColors.materialPrimary.shade600,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}
