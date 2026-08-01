// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'GPAプランナー';

  @override
  String get onboardingTagline => '追跡する。計算する。優れる。';

  @override
  String get continueButton => '続ける';

  @override
  String get languagesTitle => '言語';

  @override
  String get selectLanguageSubtitle => '言語を選択してください。設定でいつでも変更できます。';

  @override
  String get dashboardTitle => 'ダッシュボード';

  @override
  String get dashboardSubtitle => '学業成績を追跡する';

  @override
  String get dashboardHeroText => '学業目標を達成しましょう。';

  @override
  String get featuresLabel => '機能';

  @override
  String get featureGpaTitle => 'GPA計算機';

  @override
  String get featureGpaSubtitle => '学期GPA';

  @override
  String get featureCgpaTitle => 'CGPA計算機';

  @override
  String get featureCgpaSubtitle => '累積GPA';

  @override
  String get featurePercentageTitle => 'パーセントからGPAへ';

  @override
  String get featurePercentageSubtitle => '%とGPAを変換';

  @override
  String get gpaCalculatorTitle => 'GPA計算機';

  @override
  String get gpaCalculatorSubtitle => '学期GPA';

  @override
  String coursesCountTitle(int count) {
    return 'コース ($count)';
  }

  @override
  String get inputTypeManual => '入力タイプ：手動';

  @override
  String courseLabel(int number) {
    return 'コース $number';
  }

  @override
  String get courseName => '名前（任意）';

  @override
  String get obtained => '取得点';

  @override
  String get total => '合計';

  @override
  String get creditHours => '単位数';

  @override
  String get gpaCalculateButton => 'GPAを計算';

  @override
  String get cgpaCalculatorTitle => 'CGPA計算機';

  @override
  String get cgpaCalculatorSubtitle => '累積GPA';

  @override
  String semesterLabel(int number) {
    return '学期 $number';
  }

  @override
  String get percentageToGpaTitle => 'パーセントからGPAへ';

  @override
  String get percentageToGpaSubtitle => '%とGPAを変換';

  @override
  String get percentageLabel => 'パーセント';

  @override
  String get gpaLabel => 'GPA';

  @override
  String get scaleLabel => 'スケール';

  @override
  String get maxGpaLabel => '最大GPA';

  @override
  String get gotIt => '了解！';

  @override
  String get semesterResultTitle => '学期結果';

  @override
  String get yourGpa => 'あなたのGPA';

  @override
  String get percentageStat => 'パーセント';

  @override
  String get academicPerformance => '学業成績';

  @override
  String get averageMarks => '平均点';

  @override
  String get totalStat => '合計';

  @override
  String get pdfButton => 'PDF';

  @override
  String get imageButton => '画像';

  @override
  String get shareButton => '共有';

  @override
  String get downloadButton => 'ダウンロード';

  @override
  String get settingsTitle => '設定';

  @override
  String get notification => '通知';

  @override
  String get notificationSubtitle => 'メッセージが削除されたときに通知を受け取る。';

  @override
  String get resetTemplates => 'テンプレートをリセット';

  @override
  String get resetTemplatesSubtitle => 'デフォルトのコーステンプレートを復元';

  @override
  String get clearStatistics => '統計をクリア';

  @override
  String get clearStatisticsSubtitle => '保存された計算と統計をすべてリセット';

  @override
  String get chooseLanguage => '言語を選択';

  @override
  String get shareApp => '共有';

  @override
  String get shareAppSubtitle => '友達にアプリを紹介する';

  @override
  String get rateUs => '評価する';

  @override
  String get rateUsSubtitle => '最高評価をつける';

  @override
  String get feedback => 'フィードバック';

  @override
  String get gpaToPercentageTitle => 'GPAからパーセントへ';

  @override
  String get gpaToPercentageSubtitle => 'GPAと%を変換';

  @override
  String get percentageCalculateButton => 'パーセントを計算';

  @override
  String get resultPlaceholder => '結果はここに表示されます';

  @override
  String get feedbackHint => 'ご意見をお聞かせください...';

  @override
  String get cancelButton => 'キャンセル';

  @override
  String get submitButton => '送信';

  @override
  String get feedbackThanksMessage => 'フィードバックありがとうございます！';

  @override
  String get templatesResetMessage => 'テンプレートがリセットされました';

  @override
  String get statisticsClearedMessage => '統計がクリアされました';

  @override
  String get feedbackSubtitle => 'アプリの使用体験を共有する';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String get privacyPolicySubtitle => 'プライバシーガイドラインを読む';
}
