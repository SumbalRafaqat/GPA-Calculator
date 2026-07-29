/// Represents one row on the Language selection screen
/// (English, العربية, فارسی, Deutsch, Espanol, Indonesi).
class LanguageModel {
  final String code; // e.g. 'en', 'ar', 'fa', 'de', 'es', 'id'
  final String displayName; // native name shown in the list

  const LanguageModel({
    required this.code,
    required this.displayName,
  });

  /// Fixed list matching the Figma "Languages" screen order exactly.
  static const List<LanguageModel> supportedLanguages = [
    LanguageModel(code: 'en', displayName: 'English'),
    LanguageModel(code: 'ar', displayName: 'العربية'),
    LanguageModel(code: 'fa', displayName: 'فارسی'),
    LanguageModel(code: 'de', displayName: 'Deutsch'),
    LanguageModel(code: 'es', displayName: 'Espanol'),
    LanguageModel(code: 'id', displayName: 'Indonesi'),
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is LanguageModel && other.code == code;

  @override
  int get hashCode => code.hashCode;
}