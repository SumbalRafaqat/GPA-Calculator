import 'package:flutter/foundation.dart';
import '../core/services/storage_service.dart';
import '../core/utils/gpa_calculator_util.dart';
import '../core/constants/app_strings.dart';
import '../models/course_model.dart';
import '../models/gpa_result_model.dart';

class GpaCalculatorProvider extends ChangeNotifier {
  final StorageService _storage = StorageService.instance;

  final List<CourseModel> _courses = [];
  GpaResultModel? _lastResult;
  int _idCounter = 0;

  List<CourseModel> get courses => List.unmodifiable(_courses);
  GpaResultModel? get lastResult => _lastResult;

  /// True only if at least one course has real data entered
  /// (obtained marks, total marks, and credit hours all > 0).
  bool get hasValidData => _courses.any(
        (c) => c.obtainedMarks > 0 && c.totalMarks > 0 && c.creditHours > 0,
  );

  GpaCalculatorProvider() {
    addCourse();
  }

  void addCourse() {
    _courses.add(CourseModel(id: 'course_${_idCounter++}'));
    notifyListeners();
  }

  void removeCourse(String id) {
    _courses.removeWhere((course) => course.id == id);
    if (_courses.isEmpty) addCourse();
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

  void reset() {
    _courses.clear();
    _idCounter = 0;
    _lastResult = null;
    addCourse();
  }
}