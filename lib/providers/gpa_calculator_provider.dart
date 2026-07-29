import 'package:flutter/foundation.dart';
import '../core/services/storage_service.dart';
import '../core/utils/gpa_calculator_util.dart';
import '../core/constants/app_strings.dart';
import '../models/course_model.dart';
import '../models/gpa_result_model.dart';

/// ViewModel for the GPA Calculator screen (semester GPA).
/// Owns the dynamic course list, exposes calculation, and persists the
/// latest result for history/statistics.
class GpaCalculatorProvider extends ChangeNotifier {
  final StorageService _storage = StorageService.instance;

  final List<CourseModel> _courses = [];
  GpaResultModel? _lastResult;
  int _idCounter = 0;

  List<CourseModel> get courses => List.unmodifiable(_courses);
  GpaResultModel? get lastResult => _lastResult;

  GpaCalculatorProvider() {
    addCourse(); // Screen always opens with one empty "Course 1" row.
  }

  void addCourse() {
    _courses.add(CourseModel(id: 'course_${_idCounter++}'));
    notifyListeners();
  }

  void removeCourse(String id) {
    _courses.removeWhere((course) => course.id == id);
    if (_courses.isEmpty) addCourse(); // Never leave form fully empty.
    notifyListeners();
  }

  void updateCourse(
      String id, {
        String? name,
        double? obtainedMarks,
        double? totalMarks,
        double? creditHours,
      }) {
    final index = _courses.indexWhere((c) => c.id == id);
    if (index == -1) return;
    _courses[index] = _courses[index].copyWith(
      name: name,
      obtainedMarks: obtainedMarks,
      totalMarks: totalMarks,
      creditHours: creditHours,
    );
    notifyListeners();
  }

  /// Runs the GPA calculation and persists it to the saved-results
  /// history (used for the "Clear Statistics" feature in Settings).
  Future<GpaResultModel> calculate() async {
    final result = GpaCalculatorUtil.calculateGpa(_courses);
    _lastResult = result;
    notifyListeners();
    await _persistResult(result);
    return result;
  }

  Future<void> _persistResult(GpaResultModel result) async {
    final existing = _storage.getJsonList(AppStrings.keySavedGpaResults);
    existing.add(result.toJson());
    await _storage.setJsonList(AppStrings.keySavedGpaResults, existing);
  }

  /// Resets the form back to a single empty row (used by
  /// "Reset Templates" in Settings).
  void reset() {
    _courses.clear();
    _idCounter = 0;
    _lastResult = null;
    addCourse();
  }
}