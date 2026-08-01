// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'GPA Planner';

  @override
  String get onboardingTagline => 'TRACK. CALCULATE. EXCEL.';

  @override
  String get continueButton => 'Continue';

  @override
  String get languagesTitle => 'Languages';

  @override
  String get selectLanguageSubtitle =>
      'Select a language. Change it anytime in settings.';

  @override
  String get dashboardTitle => 'Dashboard';

  @override
  String get dashboardSubtitle => 'Track your academic performance';

  @override
  String get dashboardHeroText => 'Let\'s achieve your academic goals.';

  @override
  String get featuresLabel => 'FEATURES';

  @override
  String get featureGpaTitle => 'GPA Calculator';

  @override
  String get featureGpaSubtitle => 'Semester GPA';

  @override
  String get featureCgpaTitle => 'CGPA Calculator';

  @override
  String get featureCgpaSubtitle => 'Cumulative GPA';

  @override
  String get featurePercentageTitle => 'Percentage to GPA';

  @override
  String get featurePercentageSubtitle => 'Convert % and GPA';

  @override
  String get gpaCalculatorTitle => 'GPA Calculator';

  @override
  String get gpaCalculatorSubtitle => 'Semester GPA';

  @override
  String coursesCountTitle(int count) {
    return 'Courses ($count)';
  }

  @override
  String get inputTypeManual => 'Input Type: manual';

  @override
  String courseLabel(int number) {
    return 'Course $number';
  }

  @override
  String get courseName => 'Name (Optional)';

  @override
  String get obtained => 'Obtained';

  @override
  String get total => 'Total';

  @override
  String get creditHours => 'Credit Hours';

  @override
  String get gpaCalculateButton => 'GPA Calculate';

  @override
  String get cgpaCalculatorTitle => 'CGPA Calculator';

  @override
  String get cgpaCalculatorSubtitle => 'Cumulative GPA';

  @override
  String semesterLabel(int number) {
    return 'Semester $number';
  }

  @override
  String get percentageToGpaTitle => 'Percentage to GPA';

  @override
  String get percentageToGpaSubtitle => 'Convert % and GPA';

  @override
  String get percentageLabel => 'Percentage';

  @override
  String get gpaLabel => 'GPA';

  @override
  String get scaleLabel => 'Scale';

  @override
  String get maxGpaLabel => 'Max GPA';

  @override
  String get gotIt => 'Got it!';

  @override
  String get semesterResultTitle => 'Semester Result';

  @override
  String get yourGpa => 'Your GPA';

  @override
  String get percentageStat => 'Percentage';

  @override
  String get academicPerformance => 'Academic Performance';

  @override
  String get averageMarks => 'Average Marks';

  @override
  String get totalStat => 'Total';

  @override
  String get pdfButton => 'PDF';

  @override
  String get imageButton => 'Image';

  @override
  String get shareButton => 'Share';

  @override
  String get downloadButton => 'Download';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get notification => 'Notification';

  @override
  String get notificationSubtitle =>
      'Receive notification updates when messages are deleted.';

  @override
  String get resetTemplates => 'Reset Templates';

  @override
  String get resetTemplatesSubtitle => 'Restore default course templates';

  @override
  String get clearStatistics => 'Clear Statistics';

  @override
  String get clearStatisticsSubtitle =>
      'Reset all saved calculations and statistics';

  @override
  String get chooseLanguage => 'Choose Language';

  @override
  String get shareApp => 'Share';

  @override
  String get shareAppSubtitle => 'Invite friends to use the app';

  @override
  String get rateUs => 'Rate us';

  @override
  String get rateUsSubtitle => 'Give the highest rating';

  @override
  String get feedback => 'Feedback';

  @override
  String get gpaToPercentageTitle => 'GPA to Percentage';

  @override
  String get gpaToPercentageSubtitle => 'Convert GPA and %';

  @override
  String get percentageCalculateButton => 'Percentage Calculate';

  @override
  String get resultPlaceholder => 'Result will appear here';

  @override
  String get feedbackHint => 'Tell us what you think...';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get submitButton => 'Submit';

  @override
  String get feedbackThanksMessage => 'Thanks for your feedback!';

  @override
  String get templatesResetMessage => 'Templates reset';

  @override
  String get statisticsClearedMessage => 'Statistics cleared';

  @override
  String get feedbackSubtitle => 'Share your experience using our app';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get privacyPolicySubtitle => 'Read our privacy guidelines';
}
