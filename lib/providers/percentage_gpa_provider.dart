import 'package:flutter/foundation.dart';
import '../core/utils/gpa_calculator_util.dart';

/// ViewModel for the "Percentage to GPA" screen. Supports bidirectional
/// conversion: typing a Percentage auto-fills GPA, and vice versa, via
/// the swap (↔) button seen in the Figma design. Also drives the
/// "Scale / Max GPA" info dialog ("4.0 Scale, Max GPA 4.0").
class PercentageGpaProvider extends ChangeNotifier {
  double _percentage = 0;
  double _gpa = 0;
  double _maxGpa = 4.0;

  /// true = user is converting Percentage → GPA (top field is Percentage).
  /// false = user is converting GPA → Percentage (top field is GPA).
  bool _isPercentageToGpaMode = true;

  double get percentage => _percentage;
  double get gpa => _gpa;
  double get maxGpa => _maxGpa;
  bool get isPercentageToGpaMode => _isPercentageToGpaMode;

  /// Called when the user types into the Percentage input field.
  void updatePercentage(String value) {
    final parsed = double.tryParse(value);
    if (parsed == null) return;
    _percentage = parsed.clamp(0, 100);
    _gpa = GpaCalculatorUtil.percentageToGpa(_percentage, maxGpa: _maxGpa);
    notifyListeners();
  }

  /// Called when the user types into the GPA input field.
  void updateGpa(String value) {
    final parsed = double.tryParse(value);
    if (parsed == null) return;
    _gpa = parsed.clamp(0, _maxGpa);
    _percentage = GpaCalculatorUtil.gpaToPercentage(_gpa, maxGpa: _maxGpa);
    notifyListeners();
  }

  /// Swap (↔) button — flips which field is the "source" input,
  /// matching the swap icon between Percentage/GPA fields in Figma.
  void toggleDirection() {
    _isPercentageToGpaMode = !_isPercentageToGpaMode;
    notifyListeners();
  }

  /// Updates the max GPA scale (from the "Got it!" scale dialog),
  /// e.g. switching between a 4.0 scale and other institution scales.
  void setMaxGpa(double newMaxGpa) {
    _maxGpa = newMaxGpa;
    // Recompute GPA using the current percentage so numbers stay in sync.
    _gpa = GpaCalculatorUtil.percentageToGpa(_percentage, maxGpa: _maxGpa);
    notifyListeners();
  }

  void reset() {
    _percentage = 0;
    _gpa = 0;
    _isPercentageToGpaMode = true;
    notifyListeners();
  }
}