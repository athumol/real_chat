
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // Colors inspired by the reference design
  static const Color background = Color(0xFF080609);
  static const Color deepViolet = Color(0xFF24202F);
  static const Color tealShadow = Color(0xFF12303B);
  static const Color plum = Color(0xFF492A3C);
  static const Color lavender = Color(0xFFA78BFA);
  static const Color rosePink = Color(0xFFFF70B7);
  static const Color primaryText = Color(0xFFFFFFFF);
  static const Color secondaryText = Color(0xFFBDB5C5);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,

      colorScheme: const ColorScheme.dark(
        primary: rosePink,
        secondary: lavender,
        surface: deepViolet,
        error: Color(0xFFFF6B6B),
        onPrimary: background,
        onSecondary: background,
        onSurface: primaryText,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        foregroundColor: primaryText,
        elevation: 0,
        centerTitle: false,
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: deepViolet,
        hintStyle: const TextStyle(color: secondaryText),
        labelStyle: const TextStyle(color: secondaryText),
        prefixIconColor: lavender,
        suffixIconColor: lavender,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: plum.withValues(alpha: 0.8),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: lavender,
            width: 1.5,
          ),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: rosePink,
          foregroundColor: background,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: lavender,
        ),
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: rosePink,
      ),

      dividerColor: plum,
    );
  }
}
