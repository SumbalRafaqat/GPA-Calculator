// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Planificador de GPA';

  @override
  String get onboardingTagline => 'SEGUIR. CALCULAR. DESTACAR.';

  @override
  String get continueButton => 'Continuar';

  @override
  String get languagesTitle => 'Idiomas';

  @override
  String get selectLanguageSubtitle =>
      'Selecciona un idioma. Cámbialo cuando quieras en ajustes.';

  @override
  String get dashboardTitle => 'Panel';

  @override
  String get dashboardSubtitle => 'Sigue tu rendimiento académico';

  @override
  String get dashboardHeroText => 'Alcancemos tus metas académicas.';

  @override
  String get featuresLabel => 'FUNCIONES';

  @override
  String get featureGpaTitle => 'Calculadora de GPA';

  @override
  String get featureGpaSubtitle => 'GPA del semestre';

  @override
  String get featureCgpaTitle => 'Calculadora de CGPA';

  @override
  String get featureCgpaSubtitle => 'GPA acumulado';

  @override
  String get featurePercentageTitle => 'Porcentaje a GPA';

  @override
  String get featurePercentageSubtitle => 'Convertir % y GPA';

  @override
  String get gpaCalculatorTitle => 'Calculadora de GPA';

  @override
  String get gpaCalculatorSubtitle => 'GPA del semestre';

  @override
  String coursesCountTitle(int count) {
    return 'Cursos ($count)';
  }

  @override
  String get inputTypeManual => 'Tipo de entrada: manual';

  @override
  String courseLabel(int number) {
    return 'Curso $number';
  }

  @override
  String get courseName => 'Nombre (Opcional)';

  @override
  String get obtained => 'Obtenido';

  @override
  String get total => 'Total';

  @override
  String get creditHours => 'Horas de crédito';

  @override
  String get gpaCalculateButton => 'Calcular GPA';

  @override
  String get cgpaCalculatorTitle => 'Calculadora de CGPA';

  @override
  String get cgpaCalculatorSubtitle => 'GPA acumulado';

  @override
  String semesterLabel(int number) {
    return 'Semestre $number';
  }

  @override
  String get percentageToGpaTitle => 'Porcentaje a GPA';

  @override
  String get percentageToGpaSubtitle => 'Convertir % y GPA';

  @override
  String get percentageLabel => 'Porcentaje';

  @override
  String get gpaLabel => 'GPA';

  @override
  String get scaleLabel => 'Escala';

  @override
  String get maxGpaLabel => 'GPA máximo';

  @override
  String get gotIt => '¡Entendido!';

  @override
  String get semesterResultTitle => 'Resultado del semestre';

  @override
  String get yourGpa => 'Tu GPA';

  @override
  String get percentageStat => 'Porcentaje';

  @override
  String get academicPerformance => 'Rendimiento académico';

  @override
  String get averageMarks => 'Promedio de notas';

  @override
  String get totalStat => 'Total';

  @override
  String get pdfButton => 'PDF';

  @override
  String get imageButton => 'Imagen';

  @override
  String get shareButton => 'Compartir';

  @override
  String get downloadButton => 'Descargar';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get notification => 'Notificación';

  @override
  String get notificationSubtitle =>
      'Recibe actualizaciones cuando se eliminen mensajes.';

  @override
  String get resetTemplates => 'Restablecer plantillas';

  @override
  String get resetTemplatesSubtitle =>
      'Restaurar plantillas de cursos predeterminadas';

  @override
  String get clearStatistics => 'Borrar estadísticas';

  @override
  String get clearStatisticsSubtitle =>
      'Restablecer todos los cálculos y estadísticas guardados';

  @override
  String get chooseLanguage => 'Elegir idioma';

  @override
  String get shareApp => 'Compartir';

  @override
  String get shareAppSubtitle => 'Invita a tus amigos a usar la app';

  @override
  String get rateUs => 'Califícanos';

  @override
  String get rateUsSubtitle => 'Danos la mejor calificación';

  @override
  String get feedback => 'Comentarios';

  @override
  String get gpaToPercentageTitle => 'GPA a Porcentaje';

  @override
  String get gpaToPercentageSubtitle => 'Convertir GPA y %';

  @override
  String get percentageCalculateButton => 'Calcular Porcentaje';

  @override
  String get resultPlaceholder => 'El resultado aparecerá aquí';

  @override
  String get feedbackHint => 'Cuéntanos qué piensas...';

  @override
  String get cancelButton => 'Cancelar';

  @override
  String get submitButton => 'Enviar';

  @override
  String get feedbackThanksMessage => '¡Gracias por tus comentarios!';

  @override
  String get templatesResetMessage => 'Plantillas restablecidas';

  @override
  String get statisticsClearedMessage => 'Estadísticas borradas';

  @override
  String get feedbackSubtitle => 'Comparte tu experiencia usando nuestra app';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get privacyPolicySubtitle => 'Lee nuestras pautas de privacidad';
}
