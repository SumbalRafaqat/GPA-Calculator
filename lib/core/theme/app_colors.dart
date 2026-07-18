import 'package:flutter/material.dart';

/// Color palette extracted directly from the final Figma UI export.
class AppColors {
  AppColors._();

  // ---- Brand / Primary ----
  static const Color primary = Color(0xFF1E6FF2);       // main blue — buttons, dashboard banner, selected states
  static const Color primaryDark = Color(0xFF1553C4);    // pressed / darker blue
  static const Color primaryLight = Color(0xFFE9F1FE);   // faint blue tint (info backgrounds)

  // ---- Splash gradient ----
  static const Color gradientTop = Color(0xFF4B5EF0);    // splash screen top
  static const Color gradientBottom = Color(0xFF8560F5); // splash screen bottom

  // ---- Feature accent colors (dashboard icons) ----
  static const Color gpaBlue = Color(0xFF1E6FF2);        // GPA Calculator
  static const Color cgpaPurple = Color(0xFF8A5CF9);     // CGPA Calculator
  static const Color plannerGreen = Color(0xFF1FAE64);   // GPA Planner
  static const Color percentageOrange = Color(0xFFFF9F1C); // Percentage to GPA

  // ---- Status ----
  static const Color success = Color(0xFF1FAE64);
  static const Color danger = Color(0xFFEB4B4B);
  static const Color warning = Color(0xFFF5A623);

  // ---- Neutrals ----
  static const Color background = Color(0xFFFFFFFF);     // screens are white, not off-white
  static const Color surface = Color(0xFFFFFFFF);
  static const Color cardBorder = Color(0xFFE2E4E8);      // subtle card outline
  static const Color divider = Color(0xFFE2E4E8);

  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF8A8A8E);
  static const Color textHint = Color(0xFFB0B0B5);

  // ---- Chips / toggles ----
  static const Color chipInactiveBg = Color(0xFFD9D9D9);  // matches "D9D9D9" asset used across the design
  static const Color chipInactiveText = Color(0xFF3C3C3C);
  static const Color chipSelectedBg = primary;
  static const Color chipSelectedText = Colors.white;

  // ---- Dashboard feature card background ----
  static const Color featureCardTint = Color(0xFFF9F1FB); // faint lavender-pink card bg on Home tab

  // ---- Buttons ----
  static const Color darkActionButton = Color(0xFF3C3C3C); // "GPA Calculate" pill button (near-black)
}