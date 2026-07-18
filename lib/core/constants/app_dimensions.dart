/// Spacing, radius, and sizing constants measured off the final UI export
/// (360dp reference width).
class AppDimensions {
  AppDimensions._();

  // ---- Spacing scale ----
  static const double spaceXXS = 4;
  static const double spaceXS = 8;
  static const double spaceS = 12;
  static const double spaceM = 16;
  static const double spaceL = 20;   // standard screen horizontal padding
  static const double spaceXL = 24;
  static const double spaceXXL = 32;

  // ---- Radius ----
  static const double radiusCard = 20;        // section cards (Configuration, Input Method, etc.)
  static const double radiusButton = 14;       // rectangular segmented buttons (Use Marks / Use Grades)
  static const double radiusPill = 100;        // fully-rounded buttons (GPA Calculate, language rows)
  static const double radiusField = 16;        // text fields / dropdowns
  static const double radiusChip = 100;        // scale chips (4.0 / 5.0 / 10.0), quick-select numbers
  static const double radiusIcon = 12;         // feature icon square background

  // ---- Component heights ----
  static const double buttonHeight = 56;       // segmented + primary action buttons
  static const double fieldHeight = 52;
  static const double chipSize = 44;           // circular quick-select chip (3/5/6/8/10)
  static const double iconBoxSize = 44;        // feature card icon container
  static const double bottomNavHeight = 64;

  // ---- Borders ----
  static const double borderWidth = 1;
  static const double borderWidthSelected = 1.5;

  // ---- Icon sizes ----
  static const double iconS = 16;
  static const double iconM = 20;
  static const double iconL = 24;
  static const double iconXL = 40;

  // ---- Elevation / shadow ----
  static const double cardShadowBlur = 8;
  static const double cardShadowOpacity = 0.04;
}