// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'GPA 规划器';

  @override
  String get onboardingTagline => '跟踪。计算。卓越。';

  @override
  String get continueButton => '继续';

  @override
  String get languagesTitle => '语言';

  @override
  String get selectLanguageSubtitle => '选择一种语言。随时可在设置中更改。';

  @override
  String get dashboardTitle => '仪表盘';

  @override
  String get dashboardSubtitle => '跟踪您的学业表现';

  @override
  String get dashboardHeroText => '让我们实现您的学业目标。';

  @override
  String get featuresLabel => '功能';

  @override
  String get featureGpaTitle => 'GPA 计算器';

  @override
  String get featureGpaSubtitle => '学期 GPA';

  @override
  String get featureCgpaTitle => 'CGPA 计算器';

  @override
  String get featureCgpaSubtitle => '累积 GPA';

  @override
  String get featurePercentageTitle => '百分比转 GPA';

  @override
  String get featurePercentageSubtitle => '转换 % 和 GPA';

  @override
  String get gpaCalculatorTitle => 'GPA 计算器';

  @override
  String get gpaCalculatorSubtitle => '学期 GPA';

  @override
  String coursesCountTitle(int count) {
    return '课程 ($count)';
  }

  @override
  String get inputTypeManual => '输入方式：手动';

  @override
  String courseLabel(int number) {
    return '课程 $number';
  }

  @override
  String get courseName => '名称（可选）';

  @override
  String get obtained => '获得分数';

  @override
  String get total => '总分';

  @override
  String get creditHours => '学分';

  @override
  String get gpaCalculateButton => '计算 GPA';

  @override
  String get cgpaCalculatorTitle => 'CGPA 计算器';

  @override
  String get cgpaCalculatorSubtitle => '累积 GPA';

  @override
  String semesterLabel(int number) {
    return '第 $number 学期';
  }

  @override
  String get percentageToGpaTitle => '百分比转 GPA';

  @override
  String get percentageToGpaSubtitle => '转换 % 和 GPA';

  @override
  String get percentageLabel => '百分比';

  @override
  String get gpaLabel => 'GPA';

  @override
  String get scaleLabel => '量表';

  @override
  String get maxGpaLabel => '最高 GPA';

  @override
  String get gotIt => '知道了！';

  @override
  String get semesterResultTitle => '学期结果';

  @override
  String get yourGpa => '您的 GPA';

  @override
  String get percentageStat => '百分比';

  @override
  String get academicPerformance => '学业表现';

  @override
  String get averageMarks => '平均分';

  @override
  String get totalStat => '总计';

  @override
  String get pdfButton => 'PDF';

  @override
  String get imageButton => '图片';

  @override
  String get shareButton => '分享';

  @override
  String get downloadButton => '下载';

  @override
  String get settingsTitle => '设置';

  @override
  String get notification => '通知';

  @override
  String get notificationSubtitle => '消息被删除时接收通知更新。';

  @override
  String get resetTemplates => '重置模板';

  @override
  String get resetTemplatesSubtitle => '恢复默认课程模板';

  @override
  String get clearStatistics => '清除统计数据';

  @override
  String get clearStatisticsSubtitle => '重置所有已保存的计算和统计数据';

  @override
  String get chooseLanguage => '选择语言';

  @override
  String get shareApp => '分享';

  @override
  String get shareAppSubtitle => '邀请朋友使用该应用';

  @override
  String get rateUs => '给我们评分';

  @override
  String get rateUsSubtitle => '给予最高评分';

  @override
  String get feedback => '反馈';

  @override
  String get gpaToPercentageTitle => 'GPA 转百分比';

  @override
  String get gpaToPercentageSubtitle => '转换 GPA 和 %';

  @override
  String get percentageCalculateButton => '计算百分比';

  @override
  String get resultPlaceholder => '结果将显示在此处';

  @override
  String get feedbackHint => '告诉我们您的想法...';

  @override
  String get cancelButton => '取消';

  @override
  String get submitButton => '提交';

  @override
  String get feedbackThanksMessage => '感谢您的反馈！';

  @override
  String get templatesResetMessage => '模板已重置';

  @override
  String get statisticsClearedMessage => '统计数据已清除';

  @override
  String get feedbackSubtitle => '分享您使用我们应用的体验';

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String get privacyPolicySubtitle => '阅读我们的隐私指南';
}
