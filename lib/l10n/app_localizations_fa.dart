// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appTitle => 'برنامه‌ریز معدل';

  @override
  String get onboardingTagline => 'پیگیری. محاسبه. برتری.';

  @override
  String get continueButton => 'ادامه';

  @override
  String get languagesTitle => 'زبان‌ها';

  @override
  String get selectLanguageSubtitle =>
      'یک زبان انتخاب کنید. هر زمان از تنظیمات قابل تغییر است.';

  @override
  String get dashboardTitle => 'داشبورد';

  @override
  String get dashboardSubtitle => 'عملکرد تحصیلی خود را پیگیری کنید';

  @override
  String get dashboardHeroText => 'بیایید به اهداف تحصیلی خود برسیم.';

  @override
  String get featuresLabel => 'ویژگی‌ها';

  @override
  String get featureGpaTitle => 'محاسبه‌گر معدل';

  @override
  String get featureGpaSubtitle => 'معدل ترم';

  @override
  String get featureCgpaTitle => 'محاسبه‌گر معدل کل';

  @override
  String get featureCgpaSubtitle => 'معدل تجمعی';

  @override
  String get featurePercentageTitle => 'درصد به معدل';

  @override
  String get featurePercentageSubtitle => 'تبدیل درصد و معدل';

  @override
  String get gpaCalculatorTitle => 'محاسبه‌گر معدل';

  @override
  String get gpaCalculatorSubtitle => 'معدل ترم';

  @override
  String coursesCountTitle(int count) {
    return 'دروس ($count)';
  }

  @override
  String get inputTypeManual => 'نوع ورودی: دستی';

  @override
  String courseLabel(int number) {
    return 'درس $number';
  }

  @override
  String get courseName => 'نام (اختیاری)';

  @override
  String get obtained => 'نمره کسب‌شده';

  @override
  String get total => 'نمره کل';

  @override
  String get creditHours => 'واحدها';

  @override
  String get gpaCalculateButton => 'محاسبه معدل';

  @override
  String get cgpaCalculatorTitle => 'محاسبه‌گر معدل کل';

  @override
  String get cgpaCalculatorSubtitle => 'معدل تجمعی';

  @override
  String semesterLabel(int number) {
    return 'ترم $number';
  }

  @override
  String get percentageToGpaTitle => 'درصد به معدل';

  @override
  String get percentageToGpaSubtitle => 'تبدیل درصد و معدل';

  @override
  String get percentageLabel => 'درصد';

  @override
  String get gpaLabel => 'معدل';

  @override
  String get scaleLabel => 'مقیاس';

  @override
  String get maxGpaLabel => 'حداکثر معدل';

  @override
  String get gotIt => 'متوجه شدم!';

  @override
  String get semesterResultTitle => 'نتیجه ترم';

  @override
  String get yourGpa => 'معدل شما';

  @override
  String get percentageStat => 'درصد';

  @override
  String get academicPerformance => 'عملکرد تحصیلی';

  @override
  String get averageMarks => 'میانگین نمرات';

  @override
  String get totalStat => 'مجموع';

  @override
  String get pdfButton => 'PDF';

  @override
  String get imageButton => 'تصویر';

  @override
  String get shareButton => 'اشتراک‌گذاری';

  @override
  String get downloadButton => 'دانلود';

  @override
  String get settingsTitle => 'تنظیمات';

  @override
  String get notification => 'اعلان';

  @override
  String get notificationSubtitle =>
      'دریافت به‌روزرسانی اعلان هنگام حذف پیام‌ها.';

  @override
  String get resetTemplates => 'بازنشانی قالب‌ها';

  @override
  String get resetTemplatesSubtitle => 'بازگردانی قالب‌های پیش‌فرض دروس';

  @override
  String get clearStatistics => 'پاک کردن آمار';

  @override
  String get clearStatisticsSubtitle => 'بازنشانی همه محاسبات و آمار ذخیره‌شده';

  @override
  String get chooseLanguage => 'انتخاب زبان';

  @override
  String get shareApp => 'اشتراک‌گذاری';

  @override
  String get shareAppSubtitle => 'دوستان را به استفاده از برنامه دعوت کنید';

  @override
  String get rateUs => 'امتیاز دهید';

  @override
  String get rateUsSubtitle => 'بالاترین امتیاز را بدهید';

  @override
  String get feedback => 'بازخورد';

  @override
  String get gpaToPercentageTitle => 'معدل به درصد';

  @override
  String get gpaToPercentageSubtitle => 'تبدیل معدل و درصد';

  @override
  String get percentageCalculateButton => 'محاسبه درصد';

  @override
  String get resultPlaceholder => 'نتیجه اینجا نمایش داده می‌شود';

  @override
  String get feedbackHint => 'نظر خود را بگویید...';

  @override
  String get cancelButton => 'لغو';

  @override
  String get submitButton => 'ارسال';

  @override
  String get feedbackThanksMessage => 'از بازخورد شما متشکریم!';

  @override
  String get templatesResetMessage => 'قالب‌ها بازنشانی شد';

  @override
  String get statisticsClearedMessage => 'آمار پاک شد';

  @override
  String get feedbackSubtitle =>
      'تجربه خود از استفاده از برنامه را به اشتراک بگذارید';

  @override
  String get privacyPolicy => 'حریم خصوصی';

  @override
  String get privacyPolicySubtitle => 'دستورالعمل‌های حریم خصوصی ما را بخوانید';
}
