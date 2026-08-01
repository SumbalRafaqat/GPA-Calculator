// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Planificateur GPA';

  @override
  String get onboardingTagline => 'SUIVEZ. CALCULEZ. EXCELLEZ.';

  @override
  String get continueButton => 'Continuer';

  @override
  String get languagesTitle => 'Langues';

  @override
  String get selectLanguageSubtitle =>
      'Choisissez une langue. Modifiable dans les paramètres.';

  @override
  String get dashboardTitle => 'Tableau de bord';

  @override
  String get dashboardSubtitle => 'Suivez votre performance académique';

  @override
  String get dashboardHeroText => 'Atteignons vos objectifs académiques.';

  @override
  String get featuresLabel => 'FONCTIONNALITÉS';

  @override
  String get featureGpaTitle => 'Calculateur GPA';

  @override
  String get featureGpaSubtitle => 'GPA du semestre';

  @override
  String get featureCgpaTitle => 'Calculateur CGPA';

  @override
  String get featureCgpaSubtitle => 'GPA cumulatif';

  @override
  String get featurePercentageTitle => 'Pourcentage vers GPA';

  @override
  String get featurePercentageSubtitle => 'Convertir % et GPA';

  @override
  String get gpaCalculatorTitle => 'Calculateur GPA';

  @override
  String get gpaCalculatorSubtitle => 'GPA du semestre';

  @override
  String coursesCountTitle(int count) {
    return 'Cours ($count)';
  }

  @override
  String get inputTypeManual => 'Type de saisie : manuel';

  @override
  String courseLabel(int number) {
    return 'Cours $number';
  }

  @override
  String get courseName => 'Nom (Facultatif)';

  @override
  String get obtained => 'Obtenu';

  @override
  String get total => 'Total';

  @override
  String get creditHours => 'Heures de crédit';

  @override
  String get gpaCalculateButton => 'Calculer le GPA';

  @override
  String get cgpaCalculatorTitle => 'Calculateur CGPA';

  @override
  String get cgpaCalculatorSubtitle => 'GPA cumulatif';

  @override
  String semesterLabel(int number) {
    return 'Semestre $number';
  }

  @override
  String get percentageToGpaTitle => 'Pourcentage vers GPA';

  @override
  String get percentageToGpaSubtitle => 'Convertir % et GPA';

  @override
  String get percentageLabel => 'Pourcentage';

  @override
  String get gpaLabel => 'GPA';

  @override
  String get scaleLabel => 'Échelle';

  @override
  String get maxGpaLabel => 'GPA Max';

  @override
  String get gotIt => 'Compris !';

  @override
  String get semesterResultTitle => 'Résultat du semestre';

  @override
  String get yourGpa => 'Votre GPA';

  @override
  String get percentageStat => 'Pourcentage';

  @override
  String get academicPerformance => 'Performance académique';

  @override
  String get averageMarks => 'Moyenne des notes';

  @override
  String get totalStat => 'Total';

  @override
  String get pdfButton => 'PDF';

  @override
  String get imageButton => 'Image';

  @override
  String get shareButton => 'Partager';

  @override
  String get downloadButton => 'Télécharger';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get notification => 'Notification';

  @override
  String get notificationSubtitle =>
      'Recevoir des notifications lors de la suppression de messages.';

  @override
  String get resetTemplates => 'Réinitialiser les modèles';

  @override
  String get resetTemplatesSubtitle =>
      'Restaurer les modèles de cours par défaut';

  @override
  String get clearStatistics => 'Effacer les statistiques';

  @override
  String get clearStatisticsSubtitle =>
      'Réinitialiser tous les calculs et statistiques enregistrés';

  @override
  String get chooseLanguage => 'Choisir la langue';

  @override
  String get shareApp => 'Partager';

  @override
  String get shareAppSubtitle => 'Invitez des amis à utiliser l\'application';

  @override
  String get rateUs => 'Notez-nous';

  @override
  String get rateUsSubtitle => 'Donnez la meilleure note';

  @override
  String get feedback => 'Commentaires';

  @override
  String get gpaToPercentageTitle => 'GPA vers Pourcentage';

  @override
  String get gpaToPercentageSubtitle => 'Convertir GPA et %';

  @override
  String get percentageCalculateButton => 'Calculer le Pourcentage';

  @override
  String get resultPlaceholder => 'Le résultat apparaîtra ici';

  @override
  String get feedbackHint => 'Dites-nous ce que vous pensez...';

  @override
  String get cancelButton => 'Annuler';

  @override
  String get submitButton => 'Soumettre';

  @override
  String get feedbackThanksMessage => 'Merci pour votre retour !';

  @override
  String get templatesResetMessage => 'Modèles réinitialisés';

  @override
  String get statisticsClearedMessage => 'Statistiques effacées';

  @override
  String get feedbackSubtitle =>
      'Partagez votre expérience avec notre application';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get privacyPolicySubtitle => 'Lisez nos directives de confidentialité';
}
