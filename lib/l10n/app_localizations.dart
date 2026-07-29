import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fa.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fa'),
    Locale('id'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'GPA Planner'**
  String get appTitle;

  /// No description provided for @onboardingTagline.
  ///
  /// In en, this message translates to:
  /// **'TRACK. CALCULATE. EXCEL.'**
  String get onboardingTagline;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @languagesTitle.
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get languagesTitle;

  /// No description provided for @selectLanguageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select a language. Change it anytime in settings.'**
  String get selectLanguageSubtitle;

  /// No description provided for @dashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboardTitle;

  /// No description provided for @dashboardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Track your academic performance'**
  String get dashboardSubtitle;

  /// No description provided for @dashboardHeroText.
  ///
  /// In en, this message translates to:
  /// **'Let\'s achieve your academic goals.'**
  String get dashboardHeroText;

  /// No description provided for @featuresLabel.
  ///
  /// In en, this message translates to:
  /// **'FEATURES'**
  String get featuresLabel;

  /// No description provided for @featureGpaTitle.
  ///
  /// In en, this message translates to:
  /// **'GPA Calculator'**
  String get featureGpaTitle;

  /// No description provided for @featureGpaSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Semester GPA'**
  String get featureGpaSubtitle;

  /// No description provided for @featureCgpaTitle.
  ///
  /// In en, this message translates to:
  /// **'CGPA Calculator'**
  String get featureCgpaTitle;

  /// No description provided for @featureCgpaSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Cumulative GPA'**
  String get featureCgpaSubtitle;

  /// No description provided for @featurePercentageTitle.
  ///
  /// In en, this message translates to:
  /// **'Percentage to GPA'**
  String get featurePercentageTitle;

  /// No description provided for @featurePercentageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Convert % and GPA'**
  String get featurePercentageSubtitle;

  /// No description provided for @gpaCalculatorTitle.
  ///
  /// In en, this message translates to:
  /// **'GPA Calculator'**
  String get gpaCalculatorTitle;

  /// No description provided for @gpaCalculatorSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Semester GPA'**
  String get gpaCalculatorSubtitle;

  /// No description provided for @courseName.
  ///
  /// In en, this message translates to:
  /// **'Name (Optional)'**
  String get courseName;

  /// No description provided for @obtained.
  ///
  /// In en, this message translates to:
  /// **'Obtained'**
  String get obtained;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @creditHours.
  ///
  /// In en, this message translates to:
  /// **'Credit Hours'**
  String get creditHours;

  /// No description provided for @gpaCalculateButton.
  ///
  /// In en, this message translates to:
  /// **'GPA Calculate'**
  String get gpaCalculateButton;

  /// No description provided for @cgpaCalculatorTitle.
  ///
  /// In en, this message translates to:
  /// **'CGPA Calculator'**
  String get cgpaCalculatorTitle;

  /// No description provided for @cgpaCalculatorSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Cumulative GPA'**
  String get cgpaCalculatorSubtitle;

  /// No description provided for @semesterLabel.
  ///
  /// In en, this message translates to:
  /// **'Semester {number}'**
  String semesterLabel(int number);

  /// No description provided for @percentageToGpaTitle.
  ///
  /// In en, this message translates to:
  /// **'Percentage to GPA'**
  String get percentageToGpaTitle;

  /// No description provided for @percentageToGpaSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Convert % and GPA'**
  String get percentageToGpaSubtitle;

  /// No description provided for @percentageLabel.
  ///
  /// In en, this message translates to:
  /// **'Percentage'**
  String get percentageLabel;

  /// No description provided for @gpaLabel.
  ///
  /// In en, this message translates to:
  /// **'GPA'**
  String get gpaLabel;

  /// No description provided for @scaleLabel.
  ///
  /// In en, this message translates to:
  /// **'Scale'**
  String get scaleLabel;

  /// No description provided for @maxGpaLabel.
  ///
  /// In en, this message translates to:
  /// **'Max GPA'**
  String get maxGpaLabel;

  /// No description provided for @gotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it!'**
  String get gotIt;

  /// No description provided for @semesterResultTitle.
  ///
  /// In en, this message translates to:
  /// **'Semester Result'**
  String get semesterResultTitle;

  /// No description provided for @yourGpa.
  ///
  /// In en, this message translates to:
  /// **'Your GPA'**
  String get yourGpa;

  /// No description provided for @percentageStat.
  ///
  /// In en, this message translates to:
  /// **'Percentage'**
  String get percentageStat;

  /// No description provided for @academicPerformance.
  ///
  /// In en, this message translates to:
  /// **'Academic Performance'**
  String get academicPerformance;

  /// No description provided for @averageMarks.
  ///
  /// In en, this message translates to:
  /// **'Average Marks'**
  String get averageMarks;

  /// No description provided for @totalStat.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get totalStat;

  /// No description provided for @pdfButton.
  ///
  /// In en, this message translates to:
  /// **'PDF'**
  String get pdfButton;

  /// No description provided for @imageButton.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get imageButton;

  /// No description provided for @shareButton.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get shareButton;

  /// No description provided for @downloadButton.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get downloadButton;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// No description provided for @notificationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Receive notification updates when messages are deleted.'**
  String get notificationSubtitle;

  /// No description provided for @resetTemplates.
  ///
  /// In en, this message translates to:
  /// **'Reset Templates'**
  String get resetTemplates;

  /// No description provided for @resetTemplatesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Restore default course templates'**
  String get resetTemplatesSubtitle;

  /// No description provided for @clearStatistics.
  ///
  /// In en, this message translates to:
  /// **'Clear Statistics'**
  String get clearStatistics;

  /// No description provided for @clearStatisticsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Reset all saved calculations and statistics'**
  String get clearStatisticsSubtitle;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose Language'**
  String get chooseLanguage;

  /// No description provided for @shareApp.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get shareApp;

  /// No description provided for @shareAppSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Invite friends to use the app'**
  String get shareAppSubtitle;

  /// No description provided for @rateUs.
  ///
  /// In en, this message translates to:
  /// **'Rate us'**
  String get rateUs;

  /// No description provided for @rateUsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Give the highest rating'**
  String get rateUsSubtitle;

  /// No description provided for @feedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedback;

  /// No description provided for @feedbackSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Share your experience using our app'**
  String get feedbackSubtitle;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @privacyPolicySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Read our privacy guidelines'**
  String get privacyPolicySubtitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'fa',
    'id',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fa':
      return AppLocalizationsFa();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
