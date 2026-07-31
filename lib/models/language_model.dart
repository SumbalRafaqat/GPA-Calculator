/// Represents one row on the Language selection screen.
class LanguageModel {
  final String code;
  final String displayName;

  const LanguageModel({
    required this.code,
    required this.displayName,
  });

  /// Full supported language list (16 total).
  static const List<LanguageModel> supportedLanguages = [
    LanguageModel(code: 'en', displayName: 'English'),
    LanguageModel(code: 'ar', displayName: 'العربية'),
    LanguageModel(code: 'fa', displayName: 'فارسی'),
    LanguageModel(code: 'de', displayName: 'Deutsch'),
    LanguageModel(code: 'es', displayName: 'Espanol'),
    LanguageModel(code: 'id', displayName: 'Indonesi'),
    LanguageModel(code: 'fr', displayName: 'Français'),
    LanguageModel(code: 'ur', displayName: 'اردو'),
    LanguageModel(code: 'hi', displayName: 'हिन्दी'),
    LanguageModel(code: 'tr', displayName: 'Türkçe'),
    LanguageModel(code: 'pt', displayName: 'Português'),
    LanguageModel(code: 'ru', displayName: 'Русский'),
    LanguageModel(code: 'zh', displayName: '中文'),
    LanguageModel(code: 'ja', displayName: '日本語'),
    LanguageModel(code: 'ko', displayName: '한국어'),
    LanguageModel(code: 'it', displayName: 'Italiano'),
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is LanguageModel && other.code == code;

  @override
  int get hashCode => code.hashCode;
}