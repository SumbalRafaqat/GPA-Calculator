import 'package:flutter/material.dart';
import '../core/services/storage_service.dart';
import '../core/constants/app_strings.dart';
import '../models/language_model.dart';

/// ViewModel for app-wide language selection (Language screen +
/// Settings → Choose Language). Persists the chosen locale so it
/// survives app restarts.
class LocaleProvider extends ChangeNotifier {
  final StorageService _storage = StorageService.instance;

  Locale _locale = const Locale('en');
  Locale get locale => _locale;

  List<LanguageModel> get supportedLanguages =>
      LanguageModel.supportedLanguages;

  LanguageModel get currentLanguage => LanguageModel.supportedLanguages
      .firstWhere((l) => l.code == _locale.languageCode,
      orElse: () => LanguageModel.supportedLanguages.first);

  /// Loads the previously saved locale from SharedPreferences.
  /// Call once at app startup (before runApp), or on splash screen.
  Future<void> loadSavedLocale() async {
    final savedCode = _storage.getString(AppStrings.keySelectedLocale);
    if (savedCode != null &&
        LanguageModel.supportedLanguages.any((l) => l.code == savedCode)) {
      _locale = Locale(savedCode);
      notifyListeners();
    }
  }

  /// Changes the active locale and persists the choice immediately.
  Future<void> setLocale(String languageCode) async {
    if (!LanguageModel.supportedLanguages
        .any((l) => l.code == languageCode)) {
      return; // Ignore unsupported codes defensively.
    }
    _locale = Locale(languageCode);
    notifyListeners();
    await _storage.setString(AppStrings.keySelectedLocale, languageCode);
  }
}