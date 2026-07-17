// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,

      // Global Text Theme setting using Google Fonts Inter
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.light().textTheme,
      ),

      // Secondary fallback configuration for primary styles
      primaryColor: AppColors.primary,
    );
  }
}