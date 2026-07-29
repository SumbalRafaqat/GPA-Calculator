import 'package:flutter/foundation.dart';
import '../core/services/storage_service.dart';
import '../core/constants/app_strings.dart';

/// ViewModel for first-time onboarding/permission flow.
/// Determines whether the splash screen should route to onboarding
/// (Permission → Language) or straight to the Dashboard.
class OnboardingProvider extends ChangeNotifier {
  final StorageService _storage = StorageService.instance;

  bool _isOnboardingComplete = false;
  bool get isOnboardingComplete => _isOnboardingComplete;

  /// Reads the persisted flag. Call at app startup before deciding
  /// the initial route.
  void loadOnboardingStatus() {
    _isOnboardingComplete =
        _storage.getBool(AppStrings.keyOnboardingComplete);
    notifyListeners();
  }

  /// Marks onboarding as finished (called after the user picks a
  /// language on the Language screen) and persists it so onboarding
  /// never shows again.
  Future<void> completeOnboarding() async {
    _isOnboardingComplete = true;
    notifyListeners();
    await _storage.setBool(AppStrings.keyOnboardingComplete, true);
  }

  /// Resets onboarding (debug/testing use, or "Reset Templates" if it
  /// should also replay onboarding — optional).
  Future<void> resetOnboarding() async {
    _isOnboardingComplete = false;
    notifyListeners();
    await _storage.remove(AppStrings.keyOnboardingComplete);
  }
}