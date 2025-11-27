import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_style.dart';

class AppTheme {
  // Light Theme
  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: AppTextStyles.fontFamily,
    colorScheme: _lightColorScheme,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    textTheme: AppTextStyles.lightTextTheme,
    appBarTheme: _appBarTheme(),
    cardTheme: _cardTheme(AppColors.surfaceLight),
    elevatedButtonTheme: _elevatedButtonTheme(),
    inputDecorationTheme: _inputDecorationTheme(
      borderColor: AppColors.border,
      hintColor: AppColors.hint,
    ),
  );

  // Dark Theme
  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: AppTextStyles.fontFamily,
    colorScheme: _darkColorScheme,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    textTheme: AppTextStyles.darkTextTheme,
    appBarTheme: _appBarTheme(isDarkMode: true),
    cardTheme: _cardTheme(AppColors.surfaceDark),
    elevatedButtonTheme: _elevatedButtonTheme(),
    inputDecorationTheme: _inputDecorationTheme(
      borderColor: AppColors.onSurfaceDark,
      hintColor: AppColors.hint,
    ),
  );

  // Common AppBarTheme
  static AppBarTheme _appBarTheme({bool isDarkMode = false}) {
    return AppBarTheme(
      iconTheme: IconThemeData(
        color: isDarkMode ? AppColors.white : AppColors.black,
        size: 20.w,
      ),

      backgroundColor: Colors.transparent,
      // foregroundColor: AppColors.white,
      // centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,

      titleTextStyle: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: isDarkMode ? AppColors.white : AppColors.secondaryColor,
      ),
    );
  }

  // Common CardTheme
  static CardThemeData _cardTheme(Color color) {
    return CardThemeData(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: const EdgeInsets.all(8),
    );
  }

  // Common ElevatedButtonTheme
  static ElevatedButtonThemeData _elevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  // Common InputDecorationTheme
  static InputDecorationTheme _inputDecorationTheme({
    required Color borderColor,
    required Color hintColor,
  }) {
    return InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
      ),
      hintStyle: TextStyle(color: hintColor),
    );
  }

  // Light ColorScheme
  static const ColorScheme _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primaryColor,
    onPrimary: Colors.white,
    secondary: AppColors.secondaryColor,
    onSecondary: Colors.white,
    error: AppColors.error,
    onError: Colors.white,
    surface: AppColors.surfaceLight,
    onSurface: AppColors.onSurfaceLight,
  );

  // Dark ColorScheme
  static const ColorScheme _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primaryColor,
    onPrimary: Colors.white,
    secondary: AppColors.secondaryColor,
    onSecondary: Colors.white,
    error: AppColors.error,
    onError: Colors.white,
    surface: AppColors.surfaceDark,
    onSurface: AppColors.onSurfaceDark,
  );
}
