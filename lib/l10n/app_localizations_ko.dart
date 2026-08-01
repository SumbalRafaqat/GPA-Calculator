// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'GPA 플래너';

  @override
  String get onboardingTagline => '추적하세요. 계산하세요. 우수해지세요.';

  @override
  String get continueButton => '계속';

  @override
  String get languagesTitle => '언어';

  @override
  String get selectLanguageSubtitle => '언어를 선택하세요. 설정에서 언제든지 변경할 수 있습니다.';

  @override
  String get dashboardTitle => '대시보드';

  @override
  String get dashboardSubtitle => '학업 성취도를 추적하세요';

  @override
  String get dashboardHeroText => '학업 목표를 달성해봅시다.';

  @override
  String get featuresLabel => '기능';

  @override
  String get featureGpaTitle => 'GPA 계산기';

  @override
  String get featureGpaSubtitle => '학기 GPA';

  @override
  String get featureCgpaTitle => 'CGPA 계산기';

  @override
  String get featureCgpaSubtitle => '누적 GPA';

  @override
  String get featurePercentageTitle => '백분율에서 GPA로';

  @override
  String get featurePercentageSubtitle => '% 및 GPA 변환';

  @override
  String get gpaCalculatorTitle => 'GPA 계산기';

  @override
  String get gpaCalculatorSubtitle => '학기 GPA';

  @override
  String coursesCountTitle(int count) {
    return '과목 ($count)';
  }

  @override
  String get inputTypeManual => '입력 유형: 수동';

  @override
  String courseLabel(int number) {
    return '과목 $number';
  }

  @override
  String get courseName => '이름 (선택 사항)';

  @override
  String get obtained => '획득 점수';

  @override
  String get total => '총점';

  @override
  String get creditHours => '학점 시간';

  @override
  String get gpaCalculateButton => 'GPA 계산';

  @override
  String get cgpaCalculatorTitle => 'CGPA 계산기';

  @override
  String get cgpaCalculatorSubtitle => '누적 GPA';

  @override
  String semesterLabel(int number) {
    return '학기 $number';
  }

  @override
  String get percentageToGpaTitle => '백분율에서 GPA로';

  @override
  String get percentageToGpaSubtitle => '% 및 GPA 변환';

  @override
  String get percentageLabel => '백분율';

  @override
  String get gpaLabel => 'GPA';

  @override
  String get scaleLabel => '척도';

  @override
  String get maxGpaLabel => '최대 GPA';

  @override
  String get gotIt => '확인!';

  @override
  String get semesterResultTitle => '학기 결과';

  @override
  String get yourGpa => '당신의 GPA';

  @override
  String get percentageStat => '백분율';

  @override
  String get academicPerformance => '학업 성취도';

  @override
  String get averageMarks => '평균 점수';

  @override
  String get totalStat => '합계';

  @override
  String get pdfButton => 'PDF';

  @override
  String get imageButton => '이미지';

  @override
  String get shareButton => '공유';

  @override
  String get downloadButton => '다운로드';

  @override
  String get settingsTitle => '설정';

  @override
  String get notification => '알림';

  @override
  String get notificationSubtitle => '메시지가 삭제될 때 알림을 받으세요.';

  @override
  String get resetTemplates => '템플릿 재설정';

  @override
  String get resetTemplatesSubtitle => '기본 과목 템플릿 복원';

  @override
  String get clearStatistics => '통계 지우기';

  @override
  String get clearStatisticsSubtitle => '저장된 모든 계산 및 통계 재설정';

  @override
  String get chooseLanguage => '언어 선택';

  @override
  String get shareApp => '공유';

  @override
  String get shareAppSubtitle => '친구에게 앱 사용을 초대하세요';

  @override
  String get rateUs => '평가하기';

  @override
  String get rateUsSubtitle => '최고 평점을 주세요';

  @override
  String get feedback => '피드백';

  @override
  String get gpaToPercentageTitle => 'GPA에서 백분율로';

  @override
  String get gpaToPercentageSubtitle => 'GPA 및 % 변환';

  @override
  String get percentageCalculateButton => '백분율 계산';

  @override
  String get resultPlaceholder => '결과가 여기에 표시됩니다';

  @override
  String get feedbackHint => '의견을 알려주세요...';

  @override
  String get cancelButton => '취소';

  @override
  String get submitButton => '제출';

  @override
  String get feedbackThanksMessage => '피드백 감사합니다!';

  @override
  String get templatesResetMessage => '템플릿이 재설정되었습니다';

  @override
  String get statisticsClearedMessage => '통계가 지워졌습니다';

  @override
  String get feedbackSubtitle => '앱 사용 경험을 공유해주세요';

  @override
  String get privacyPolicy => '개인정보 처리방침';

  @override
  String get privacyPolicySubtitle => '개인정보 보호 지침을 읽어보세요';
}
