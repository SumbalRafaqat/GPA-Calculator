// lib/core/theme/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // Brand Main Colors
  static const Color primary = Color(0xFF2F80ED);      // Vibrant Blue (Main CTA, Selected states)
  static const Color primaryGradientStart = Color(0xFF1572E8);
  static const Color primaryGradientEnd = Color(0xFF3399FF);

  // Neutral Colors
  static const Color background = Color(0xFFF8FAFC);   // Pure Light Calm Bg
  static const Color cardBg = Color(0xFFFFFFFF);       // White card layout
  static const Color textMain = Color(0xFF1E293B);     // Dark Slate (Titles)
  static const Color textSecondary = Color(0xFF64748B); // Muted Blue-Grey (Subtitles)
  static const Color textLight = Color(0xFF94A3B8);     // Sandy Gray (Placeholders/Hints)

  // Field & Borders
  static const Color fieldBackground = Color(0xFFF1F5F9); // Light Grey for TextFields
  static const Color border = Color(0xFFE2E8F0);        // Subtle divider lines

  // Status Colors
  static const Color success = Color(0xFF10B981);      // Green badge
  static const Color error = Color(0xFFEF4444);        // Warning/Target Not Achievable (Red)
  static const Color inactive = Color(0xFFE2E8F0);     // Inactive chips background
}