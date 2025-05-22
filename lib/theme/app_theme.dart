import 'package:flutter/material.dart';
import 'package:fund_watchlist/theme/app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColor.background,
      primaryColor: AppColor.primary,
      fontFamily: 'Ubuntu',
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColor.background,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColor.textPrimary),
        titleTextStyle: TextStyle(
          color: AppColor.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColor.textPrimary),
        bodyMedium: TextStyle(color: AppColor.textPrimary),
        labelLarge: TextStyle(color: AppColor.textPrimary),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColor.surface,
        hintStyle: const TextStyle(color: AppColor.textSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColor.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColor.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColor.primary),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          foregroundColor: Colors.white,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColor.textSecondary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          foregroundColor: AppColor.textPrimary,
        ),
      ),
      iconTheme: const IconThemeData(color: AppColor.textPrimary),
      tabBarTheme: TabBarTheme(
        labelColor: AppColor.primary,
        unselectedLabelColor: AppColor.textSecondary,
        indicator: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColor.primary, width: 2),
          ),
        ),
      ),
    );
  }
}
