import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:engaz_task/app/core/constants/app_colors.dart';
import 'package:engaz_task/app/core/helper/responsive_text.dart';

class AppTheme {
  // 🎯 Dialog Configuration
  static const double dialogBorderRadius = 12;
  static const double dialogWidth = 800;
  static const double dialogMaxHeightRatio = 0.9;
  static const double dialogPadding = 24;
  static const double formFieldBorderRadius = 8;
  static const double formFieldLabelFontSize = 14;
  static const double formFieldHintFontSize = 14;
  static const double formFieldBorderWidth = 1;
  static const double formFieldFocusedBorderWidth = 2;
  static const double dialogTitleFontSize = 20;
  // 🌓 الوضع الفاتح
  static ThemeData get lightTheme {
    return ThemeData(
      datePickerTheme: DatePickerThemeData(
        backgroundColor: Colors.white,
        headerBackgroundColor: AppColors.greenLight,
        headerForegroundColor: Colors.white,
        dayForegroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return AppColors.black;
        }),
        dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.greenLight;
          }
          return Colors.transparent;
        }),
        todayForegroundColor: WidgetStateProperty.all(AppColors.greenLight),
        todayBackgroundColor: WidgetStateProperty.all(
          AppColors.greenLight.withValues(alpha: 0.2),
        ),
      ),
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.primary,
      fontFamily: 'Switzer',
      colorScheme: const ColorScheme(
        primary: AppColors.primary, // اللون الثاني
        secondary: AppColors.primaryText, // اللون الثانوي الثاني
        surface: Colors.white, // خلفية التطبيقات
        error: AppColors.danger, // اللون الخاص بالأخطاء
        onPrimary: AppColors.primaryButton, // اللون عند استخدام الـ primary
        onSecondary: Colors.black, // اللون عند استخدام الـ secondary
        onSurface: AppColors.gray, // اللون عند استخدام الـ background
        onError: Colors.white, // اللون عند استخدام الـ error
        brightness: Brightness.light, // مستوى السطوع (فاتح أو غامق)
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.white,
        iconTheme: const IconThemeData(color: AppColors.primary),
        titleTextStyle: TextStyle(
          color: AppColors.primary,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
        actionsIconTheme: const IconThemeData(color: AppColors.primary),
      ),
      radioTheme: const RadioThemeData(
        fillColor: WidgetStatePropertyAll(AppColors.primary),
        // overlayColor: WidgetStatePropertyAll(
        //   AppColors.primaryColor.withValues(alpha: 0.2),
        // ),
      ),
      switchTheme: SwitchThemeData(
        overlayColor: WidgetStatePropertyAll(
          AppColors.white.withValues(alpha: 0.4),
        ),
        thumbColor: const WidgetStatePropertyAll(AppColors.white),
        trackColor: const WidgetStatePropertyAll(AppColors.green),
        trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      ),
      textTheme: TextTheme(
        displayLarge: textStyle(
          responsiveFontSize(30, 28, 24),
          FontWeight.bold,
          AppColors.primaryButton,
        ),
        displayMedium: textStyle(
          responsiveFontSize(26, 22, 20),
          FontWeight.bold,
          AppColors.white,
        ),
        displaySmall: textStyle(
          responsiveFontSize(22, 20, 18),
          FontWeight.w600,
          AppColors.white,
        ),
        headlineMedium: textStyle(
          responsiveFontSize(18, 16, 14),
          FontWeight.bold,
          AppColors.black,
        ),
        bodyLarge: textStyle(
          responsiveFontSize(16, 14, 12),
          FontWeight.normal,
          AppColors.black,
        ),
        bodyMedium: textStyle(
          responsiveFontSize(14, 12, 10),
          FontWeight.normal,
          AppColors.black,
        ),
        bodySmall: textStyle(
          responsiveFontSize(12, 10, 8),
          FontWeight.normal,
          AppColors.black,
        ),
      ),
      cardColor: AppColors.primary,
      buttonTheme: ButtonThemeData(
        buttonColor: AppColors.primaryButton,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: AppColors.primaryButton,
          textStyle: textStyle(16, FontWeight.bold, Colors.white),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
    );
  }

  // // 🌙 الوضع الداكن

  // 🌙 الوضع الداكن
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.materialPrimary,
      fontFamily: 'Switzer',
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: textStyle(
          responsiveFontSize(30, 28, 24),
          FontWeight.bold,
          AppColors.primaryButton,
        ),
        displayMedium: textStyle(
          responsiveFontSize(26, 22, 20),
          FontWeight.bold,
          AppColors.white,
        ),
        displaySmall: textStyle(
          responsiveFontSize(22, 20, 18),
          FontWeight.w600,
          AppColors.white,
        ),
        headlineMedium: textStyle(
          responsiveFontSize(18, 16, 14),
          FontWeight.bold,
          AppColors.black,
        ),
        bodyLarge: textStyle(
          responsiveFontSize(16, 14, 12),
          FontWeight.normal,
          AppColors.black,
        ),
        bodyMedium: textStyle(
          responsiveFontSize(14, 12, 10),
          FontWeight.normal,
          AppColors.black,
        ),
        bodySmall: textStyle(
          responsiveFontSize(12, 10, 8),
          FontWeight.normal,
          AppColors.black,
        ),
      ),
      cardColor: Colors.grey[900],
      buttonTheme: ButtonThemeData(
        buttonColor: AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: AppColors.primary,
          textStyle: textStyle(16, FontWeight.bold, Colors.white),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  // 🎨 دالة لإنشاء TextStyle بسهولة
  static TextStyle textStyle(double size, FontWeight weight, Color color) {
    return TextStyle(
      fontSize: size,
      fontWeight: weight,
      color: color,
      fontFamily: 'Switzer',
    );
  }

  // 🎯 Dialog Title TextStyle
  static TextStyle get dialogTitleStyle {
    return TextStyle(
      fontSize: dialogTitleFontSize.sp,
      fontWeight: FontWeight.bold,
      color: AppColors.secondaryBackground,
    );
  }

  // 🎯 Form Field Label TextStyle
  static TextStyle get formFieldLabelStyle {
    return TextStyle(
      fontSize: formFieldLabelFontSize.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.secondaryBackground,
    );
  }

  // 🎯 Form Field Hint TextStyle
  static TextStyle get formFieldHintStyle {
    return TextStyle(
      fontSize: formFieldHintFontSize.sp,
      color: const Color(0xFFA0AEC0),
    );
  }

  // 🎯 Form Field Helper Text Style
  static TextStyle get formFieldHelperTextStyle {
    return TextStyle(
      fontSize: 11.sp,
      color: AppColors.secondary,
    );
  }

  // 🎯 Build Form Field Input Decoration
  static InputDecoration buildFormFieldDecoration({
    required String hintText,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: formFieldHintStyle,
      filled: true,
      fillColor: AppColors.scaffoldBackgroundColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(formFieldBorderRadius.r),
        borderSide: const BorderSide(color: AppColors.primary20),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(formFieldBorderRadius.r),
        borderSide: const BorderSide(color: AppColors.primary20),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(formFieldBorderRadius.r),
        borderSide: const BorderSide(
          color: AppColors.primary,
          width: formFieldFocusedBorderWidth,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(formFieldBorderRadius.r),
        borderSide: const BorderSide(color: AppColors.danger),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(formFieldBorderRadius.r),
        borderSide: const BorderSide(
          color: AppColors.danger,
          width: formFieldFocusedBorderWidth,
        ),
      ),
      suffixIcon: suffixIcon,
    );
  }

  // 🎯 Dialog Close Icon
  static IconButton get dialogCloseButton {
    return const IconButton(
      icon: Icon(Icons.close, color: Color(0xFF718096)),
      onPressed: null, // Will be set by the dialog
    );
  }

  // 🎯 Barcode Button Style Container
  static BoxDecoration get barcodeScanButtonDecoration {
    return BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(4.r),
    );
  }
}
