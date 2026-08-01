// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Планировщик GPA';

  @override
  String get onboardingTagline => 'ОТСЛЕЖИВАЙ. СЧИТАЙ. ПРЕВОСХОДИ.';

  @override
  String get continueButton => 'Продолжить';

  @override
  String get languagesTitle => 'Языки';

  @override
  String get selectLanguageSubtitle =>
      'Выберите язык. Измените в любое время в настройках.';

  @override
  String get dashboardTitle => 'Панель';

  @override
  String get dashboardSubtitle => 'Отслеживайте свою успеваемость';

  @override
  String get dashboardHeroText =>
      'Давайте достигнем ваших академических целей.';

  @override
  String get featuresLabel => 'ФУНКЦИИ';

  @override
  String get featureGpaTitle => 'Калькулятор GPA';

  @override
  String get featureGpaSubtitle => 'GPA за семестр';

  @override
  String get featureCgpaTitle => 'Калькулятор CGPA';

  @override
  String get featureCgpaSubtitle => 'Совокупный GPA';

  @override
  String get featurePercentageTitle => 'Процент в GPA';

  @override
  String get featurePercentageSubtitle => 'Конвертировать % и GPA';

  @override
  String get gpaCalculatorTitle => 'Калькулятор GPA';

  @override
  String get gpaCalculatorSubtitle => 'GPA за семестр';

  @override
  String coursesCountTitle(int count) {
    return 'Курсы ($count)';
  }

  @override
  String get inputTypeManual => 'Тип ввода: вручную';

  @override
  String courseLabel(int number) {
    return 'Курс $number';
  }

  @override
  String get courseName => 'Название (Необязательно)';

  @override
  String get obtained => 'Получено';

  @override
  String get total => 'Всего';

  @override
  String get creditHours => 'Кредитные часы';

  @override
  String get gpaCalculateButton => 'Рассчитать GPA';

  @override
  String get cgpaCalculatorTitle => 'Калькулятор CGPA';

  @override
  String get cgpaCalculatorSubtitle => 'Совокупный GPA';

  @override
  String semesterLabel(int number) {
    return 'Семестр $number';
  }

  @override
  String get percentageToGpaTitle => 'Процент в GPA';

  @override
  String get percentageToGpaSubtitle => 'Конвертировать % и GPA';

  @override
  String get percentageLabel => 'Процент';

  @override
  String get gpaLabel => 'GPA';

  @override
  String get scaleLabel => 'Шкала';

  @override
  String get maxGpaLabel => 'Макс. GPA';

  @override
  String get gotIt => 'Понятно!';

  @override
  String get semesterResultTitle => 'Результат семестра';

  @override
  String get yourGpa => 'Ваш GPA';

  @override
  String get percentageStat => 'Процент';

  @override
  String get academicPerformance => 'Успеваемость';

  @override
  String get averageMarks => 'Средний балл';

  @override
  String get totalStat => 'Всего';

  @override
  String get pdfButton => 'PDF';

  @override
  String get imageButton => 'Изображение';

  @override
  String get shareButton => 'Поделиться';

  @override
  String get downloadButton => 'Скачать';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get notification => 'Уведомление';

  @override
  String get notificationSubtitle =>
      'Получать уведомления при удалении сообщений.';

  @override
  String get resetTemplates => 'Сбросить шаблоны';

  @override
  String get resetTemplatesSubtitle =>
      'Восстановить шаблоны курсов по умолчанию';

  @override
  String get clearStatistics => 'Очистить статистику';

  @override
  String get clearStatisticsSubtitle =>
      'Сбросить все сохраненные расчеты и статистику';

  @override
  String get chooseLanguage => 'Выбрать язык';

  @override
  String get shareApp => 'Поделиться';

  @override
  String get shareAppSubtitle => 'Пригласите друзей использовать приложение';

  @override
  String get rateUs => 'Оцените нас';

  @override
  String get rateUsSubtitle => 'Поставьте высшую оценку';

  @override
  String get feedback => 'Отзыв';

  @override
  String get gpaToPercentageTitle => 'GPA в Процент';

  @override
  String get gpaToPercentageSubtitle => 'Конвертировать GPA и %';

  @override
  String get percentageCalculateButton => 'Рассчитать процент';

  @override
  String get resultPlaceholder => 'Результат появится здесь';

  @override
  String get feedbackHint => 'Расскажите, что вы думаете...';

  @override
  String get cancelButton => 'Отмена';

  @override
  String get submitButton => 'Отправить';

  @override
  String get feedbackThanksMessage => 'Спасибо за ваш отзыв!';

  @override
  String get templatesResetMessage => 'Шаблоны сброшены';

  @override
  String get statisticsClearedMessage => 'Статистика очищена';

  @override
  String get feedbackSubtitle =>
      'Поделитесь опытом использования нашего приложения';

  @override
  String get privacyPolicy => 'Политика конфиденциальности';

  @override
  String get privacyPolicySubtitle =>
      'Прочитайте наши правила конфиденциальности';
}
