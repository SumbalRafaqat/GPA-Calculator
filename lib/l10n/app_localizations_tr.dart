// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'GPA Planlayıcı';

  @override
  String get onboardingTagline => 'TAKİP ET. HESAPLA. BAŞAR.';

  @override
  String get continueButton => 'Devam et';

  @override
  String get languagesTitle => 'Diller';

  @override
  String get selectLanguageSubtitle =>
      'Bir dil seçin. İstediğiniz zaman ayarlardan değiştirin.';

  @override
  String get dashboardTitle => 'Panel';

  @override
  String get dashboardSubtitle => 'Akademik performansınızı takip edin';

  @override
  String get dashboardHeroText => 'Akademik hedeflerinize ulaşalım.';

  @override
  String get featuresLabel => 'ÖZELLİKLER';

  @override
  String get featureGpaTitle => 'GPA Hesaplayıcı';

  @override
  String get featureGpaSubtitle => 'Dönem GPA';

  @override
  String get featureCgpaTitle => 'CGPA Hesaplayıcı';

  @override
  String get featureCgpaSubtitle => 'Kümülatif GPA';

  @override
  String get featurePercentageTitle => 'Yüzdeden GPA\'ya';

  @override
  String get featurePercentageSubtitle => '% ve GPA dönüştür';

  @override
  String get gpaCalculatorTitle => 'GPA Hesaplayıcı';

  @override
  String get gpaCalculatorSubtitle => 'Dönem GPA';

  @override
  String coursesCountTitle(int count) {
    return 'Dersler ($count)';
  }

  @override
  String get inputTypeManual => 'Giriş Türü: manuel';

  @override
  String courseLabel(int number) {
    return 'Ders $number';
  }

  @override
  String get courseName => 'Ad (İsteğe bağlı)';

  @override
  String get obtained => 'Alınan';

  @override
  String get total => 'Toplam';

  @override
  String get creditHours => 'Kredi Saati';

  @override
  String get gpaCalculateButton => 'GPA Hesapla';

  @override
  String get cgpaCalculatorTitle => 'CGPA Hesaplayıcı';

  @override
  String get cgpaCalculatorSubtitle => 'Kümülatif GPA';

  @override
  String semesterLabel(int number) {
    return 'Dönem $number';
  }

  @override
  String get percentageToGpaTitle => 'Yüzdeden GPA\'ya';

  @override
  String get percentageToGpaSubtitle => '% ve GPA dönüştür';

  @override
  String get percentageLabel => 'Yüzde';

  @override
  String get gpaLabel => 'GPA';

  @override
  String get scaleLabel => 'Ölçek';

  @override
  String get maxGpaLabel => 'Maks GPA';

  @override
  String get gotIt => 'Anladım!';

  @override
  String get semesterResultTitle => 'Dönem Sonucu';

  @override
  String get yourGpa => 'GPA\'nız';

  @override
  String get percentageStat => 'Yüzde';

  @override
  String get academicPerformance => 'Akademik Performans';

  @override
  String get averageMarks => 'Ortalama Not';

  @override
  String get totalStat => 'Toplam';

  @override
  String get pdfButton => 'PDF';

  @override
  String get imageButton => 'Resim';

  @override
  String get shareButton => 'Paylaş';

  @override
  String get downloadButton => 'İndir';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get notification => 'Bildirim';

  @override
  String get notificationSubtitle => 'Mesajlar silindiğinde bildirim al.';

  @override
  String get resetTemplates => 'Şablonları Sıfırla';

  @override
  String get resetTemplatesSubtitle =>
      'Varsayılan ders şablonlarını geri yükle';

  @override
  String get clearStatistics => 'İstatistikleri Temizle';

  @override
  String get clearStatisticsSubtitle =>
      'Tüm kayıtlı hesaplamaları ve istatistikleri sıfırla';

  @override
  String get chooseLanguage => 'Dil Seç';

  @override
  String get shareApp => 'Paylaş';

  @override
  String get shareAppSubtitle => 'Arkadaşlarını uygulamayı kullanmaya davet et';

  @override
  String get rateUs => 'Bizi Değerlendir';

  @override
  String get rateUsSubtitle => 'En yüksek puanı ver';

  @override
  String get feedback => 'Geri Bildirim';

  @override
  String get gpaToPercentageTitle => 'GPA\'dan Yüzdeye';

  @override
  String get gpaToPercentageSubtitle => 'GPA ve % dönüştür';

  @override
  String get percentageCalculateButton => 'Yüzde Hesapla';

  @override
  String get resultPlaceholder => 'Sonuç burada görünecek';

  @override
  String get feedbackHint => 'Ne düşündüğünüzü bize söyleyin...';

  @override
  String get cancelButton => 'İptal';

  @override
  String get submitButton => 'Gönder';

  @override
  String get feedbackThanksMessage => 'Geri bildiriminiz için teşekkürler!';

  @override
  String get templatesResetMessage => 'Şablonlar sıfırlandı';

  @override
  String get statisticsClearedMessage => 'İstatistikler temizlendi';

  @override
  String get feedbackSubtitle => 'Uygulamamızla ilgili deneyimini paylaş';

  @override
  String get privacyPolicy => 'Gizlilik Politikası';

  @override
  String get privacyPolicySubtitle => 'Gizlilik yönergelerimizi oku';
}
