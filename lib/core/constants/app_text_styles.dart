import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Shared TextStyle set matching Figma type scale.
/// Widgets should reference these instead of inlining TextStyle(...),
/// so font changes propagate app-wide from one place.
class AppTextStyles {
  AppTextStyles._();

  // Onboarding: "GPA Planner" big title on splash/permission screen.
  static const TextStyle onboardingTitle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    color: AppColors.textOnPrimary,
  );

  // Onboarding: "TRACK. CALCULATE. EXCEL." tagline (letter-spaced caps).
  static const TextStyle onboardingTagline = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.2,
    color: AppColors.textOnPrimary,
  );

  // Screen title, e.g. "Dashboard", "CGPA Calculator".
  static const TextStyle screenTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  // Screen subtitle, e.g. "Track your academic performance".
  static const TextStyle screenSubtitle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  // Dashboard hero card message: "Let's achieve your academic goals."
  static const TextStyle heroCardText = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.textOnPrimary,
    height: 1.3,
  );

  // Feature card title, e.g. "GPA Calculator".
  static const TextStyle cardTitle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  // Feature card subtitle, e.g. "Semester GPA".
  static const TextStyle cardSubtitle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  // Result screen: "Your GPA" label (white, inside blue card).
  static const TextStyle resultLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textOnPrimary,
  );

  // Result screen: huge GPA number, e.g. "1.76".
  static const TextStyle resultValueLarge = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w800,
    color: AppColors.textOnPrimary,
  );

  // Stat card number, e.g. "18", "48.8".
  static const TextStyle statValue = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  // Stat card label, e.g. "Credit Hours", "Percentage".
  static const TextStyle statLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  // Input field label, e.g. "Obtained", "Total", "Credit Hours".
  static const TextStyle inputLabel = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );

  // Settings list item title, e.g. "Notification", "Reset Templates".
  static const TextStyle listItemTitle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // Settings list item subtitle, e.g. "Receive notification updates...".
  static const TextStyle listItemSubtitle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  // Button text.
  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textOnPrimary,
  );
}