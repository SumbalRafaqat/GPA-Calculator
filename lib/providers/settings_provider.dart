import 'package:flutter/foundation.dart';
import '../core/services/storage_service.dart';
import '../core/constants/app_strings.dart';

/// ViewModel for the Settings screen: Notification toggle, Reset
/// Templates, Clear Statistics. (Choose Language is handled by
/// LocaleProvider; Share/Rate/Feedback/Privacy are external links,
/// no state needed.)
class SettingsProvider extends ChangeNotifier {
  final StorageService _storage = StorageService.instance;

  bool _notificationsEnabled = true;
  bool get notificationsEnabled => _notificationsEnabled;

  bool _isClearing = false;
  bool get isClearing => _isClearing;

  /// Loads persisted settings. Call when the Settings screen opens.
  void loadSettings() {
    _notificationsEnabled = _storage.getBool(
      AppStrings.keyNotificationsEnabled,
      defaultValue: true,
    );
    notifyListeners();
  }

  /// Toggles the notification switch and persists immediately.
  Future<void> toggleNotifications(bool value) async {
    _notificationsEnabled = value;
    notifyListeners();
    await _storage.setBool(AppStrings.keyNotificationsEnabled, value);
  }

  /// "Reset Templates" — clears any saved default course/semester
  /// templates so calculators start fresh next time they're opened.
  /// (Course/semester lists themselves live in memory per-provider,
  /// so this clears only persisted template data, not live state.)
  Future<void> resetTemplates() async {
    _isClearing = true;
    notifyListeners();
    // Currently no separate "template" key is persisted beyond results,
    // reserved here for future default-template presets.
    await Future.delayed(const Duration(milliseconds: 300));
    _isClearing = false;
    notifyListeners();
  }

  /// "Clear Statistics" — wipes saved GPA/CGPA result history used for
  /// any statistics/history screen.
  Future<void> clearStatistics() async {
    _isClearing = true;
    notifyListeners();
    await _storage.remove(AppStrings.keySavedGpaResults);
    await _storage.remove(AppStrings.keySavedCgpaResults);
    _isClearing = false;
    notifyListeners();
  }
}