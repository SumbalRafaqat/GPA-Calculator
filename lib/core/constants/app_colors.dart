import 'package:flutter/material.dart';

/// Centralized color palette for GPA Planner.
/// Single source of truth — update design system colors from here only.
class AppColors {
  AppColors._();

  // Primary brand color (Figma #3A62FF) — used on buttons, dashboard card,
  // selected radio, active nav indicator.
  static const Color primary = Color(0xFF3A62FF);
  static const Color primaryDark = Color(0xFF2647D6);
  static const Color primaryLight = Color(0xFFEAF0FF); // selected language bg

  // Base surfaces.
  static const Color background = Color(0xFFF7F8FA);
  static const Color surface = Colors.white;
  static const Color border = Color(0xFFE2E5EC);

  // Text.
  static const Color textPrimary = Color(0xFF1A1D26);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textOnPrimary = Colors.white;

  // Feature card icon backgrounds (Dashboard: GPA / CGPA / Percentage).
  static const Color gpaIconBg = Color(0xFFEAF0FF);
  static const Color gpaIconColor = Color(0xFF3A62FF);

  static const Color cgpaIconBg = Color(0xFFF1EBFF);
  static const Color cgpaIconColor = Color(0xFF7B5CFA);

  static const Color percentageIconBg = Color(0xFFFEF1E3);
  static const Color percentageIconColor = Color(0xFFF59B3A);

  // Status / action colors.
  static const Color deleteRed = Color(0xFFE04C4C);
  static const Color disabledButton = Color(0xFF9AA0AC);

  // Onboarding gradient (splash / permission screen purple-blue bg).
  static const Color onboardingGradientStart = Color(0xFF5B6EF5);
  static const Color onboardingGradientEnd = Color(0xFF3A62FF);
}