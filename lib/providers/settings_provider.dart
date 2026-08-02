import 'package:flutter/foundation.dart';
import '../core/services/storage_service.dart';
import '../core/services/notification_service.dart';
import '../core/constants/app_strings.dart';

/// ViewModel for the Settings screen: Notification toggle, Reset
/// Templates, Clear Statistics.
class SettingsProvider extends ChangeNotifier {
  final StorageService _storage = StorageService.instance;
  final NotificationService _notificationService = NotificationService.instance;

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

    // Re-sync the actual scheduled notification with the saved preference
    // (in case it wasn't scheduled yet, e.g. after app reinstall).
    if (_notificationsEnabled) {
      _notificationService.scheduleDailyReminder();
    }
  }

  /// Toggles the notification switch, persists it, and schedules or
  /// cancels the real daily reminder notification accordingly.
  Future<void> toggleNotifications(bool value) async {
    _notificationsEnabled = value;
    notifyListeners();
    await _storage.setBool(AppStrings.keyNotificationsEnabled, value);

    if (value) {
      final granted = await _notificationService.requestPermission();
      if (granted) {
        await _notificationService.scheduleDailyReminder();
      }
    } else {
      await _notificationService.cancelDailyReminder();
    }
  }

  Future<void> resetTemplates() async {
    _isClearing = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 300));
    _isClearing = false;
    notifyListeners();
  }

  Future<void> clearStatistics() async {
    _isClearing = true;
    notifyListeners();
    await _storage.remove(AppStrings.keySavedGpaResults);
    await _storage.remove(AppStrings.keySavedCgpaResults);
    _isClearing = false;
    notifyListeners();
  }
}