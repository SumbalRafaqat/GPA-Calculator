/// Shared spacing, radius, and sizing constants.
/// Keeps every screen's padding/margins/radii consistent without
/// scattering magic numbers across widget files.
class AppDimensions {
  AppDimensions._();

  // Spacing scale (based on Figma's 4/8/12/16/24 rhythm).
  static const double spaceXs = 4.0;
  static const double spaceSm = 8.0;
  static const double spaceMd = 12.0;
  static const double spaceLg = 16.0;
  static const double spaceXl = 24.0;
  static const double spaceXxl = 32.0;

  // Screen-level padding (used as Scaffold body padding on every screen).
  static const double screenPadding = 16.0;

  // Border radius.
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;   // input fields
  static const double radiusLg = 16.0;   // cards (course card, feature card)
  static const double radiusXl = 20.0;   // dashboard hero blue card
  static const double radiusPill = 999.0; // fully rounded buttons/badges

  // Component heights.
  static const double buttonHeight = 52.0;
  static const double inputHeight = 48.0;
  static const double appBarHeight = 56.0;

  // Icon sizes.
  static const double iconSm = 18.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;

  // Feature card icon container (Dashboard: rounded square behind icon).
  static const double featureIconBoxSize = 44.0;

  // Onboarding graduation-cap logo container size.
  static const double onboardingLogoSize = 96.0;
}