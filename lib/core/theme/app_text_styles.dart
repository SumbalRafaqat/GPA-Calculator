import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Typography scale matched to the final UI export — all styles use
/// Google Fonts' Inter (project-wide font).
class AppTextStyles {
  AppTextStyles._();

  // Screen titles ("Dashboard", "GPA Planner")
  static TextStyle get h1 => GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  // Section titles inside cards ("Configuration", "Semester 1") — primary blue
  static TextStyle get sectionTitle => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
    height: 1.3,
  );

  // Card headers in neutral text ("Input Method", "Custom Grading Settings")
  static TextStyle get h2 => GoogleFonts.inter(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static TextStyle get body => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static TextStyle get bodyBold => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  // Subtitles under titles ("Track your academic performance")
  static TextStyle get caption => GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.3,
  );

  static TextStyle get captionSmall => GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  // Big result numbers ("1.76" GPA)
  static TextStyle get displayNumber => GoogleFonts.inter(
    fontSize: 40,
    fontWeight: FontWeight.w800,
    color: Colors.white,
    height: 1.1,
  );

  // Stat tile values ("18", "48.8")
  static TextStyle get statValue => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  // Button label text
  static TextStyle get buttonLabel => GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static TextStyle get buttonLabelDark => GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  // Text field label + input
  static TextStyle get fieldLabel => GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static TextStyle get fieldInput => GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static TextStyle get fieldHint => GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textHint,
  );

  // Bottom nav labels
  static TextStyle get navLabel => GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w600,
  );

  /// TextTheme for MaterialApp — pre-built with Inter via google_fonts,
  /// so any widget reading Theme.of(context).textTheme also gets Inter.
  static TextTheme get textTheme => GoogleFonts.interTextTheme();
}