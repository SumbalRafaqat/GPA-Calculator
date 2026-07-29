/// Non-translatable constants: SharedPreferences keys and asset paths.
/// User-facing display text lives in lib/l10n/*.arb — NOT here.
class AppStrings {
  AppStrings._();

  // SharedPreferences keys.
  static const String keyOnboardingComplete = 'onboarding_complete';
  static const String keySelectedLocale = 'selected_locale';
  static const String keyNotificationsEnabled = 'notifications_enabled';
  static const String keySavedGpaResults = 'saved_gpa_results';
  static const String keySavedCgpaResults = 'saved_cgpa_results';

  // Asset paths.
  static const String iconGraduationCap = 'assets/icons/graduation_cap.svg';
  static const String iconGpaCalculator = 'assets/icons/gpa_calculator.svg';
  static const String iconCgpaCalculator = 'assets/icons/cgpa_calculator.svg';
  static const String iconPercentage = 'assets/icons/percentage.svg';
}