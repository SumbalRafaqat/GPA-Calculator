import 'package:flutter/foundation.dart';
import '../core/services/storage_service.dart';
import '../core/utils/gpa_calculator_util.dart';
import '../core/constants/app_strings.dart';
import '../models/semester_model.dart';

class CgpaCalculatorProvider extends ChangeNotifier {
  final StorageService _storage = StorageService.instance;

  final List<SemesterModel> _semesters = [];
  double? _lastCgpa;
  int _idCounter = 0;

  List<SemesterModel> get semesters => List.unmodifiable(_semesters);
  double? get lastCgpa => _lastCgpa;

  /// True only if at least one semester has a GPA entered.
  bool get hasValidData => _semesters.any((s) => s.gpa != null && s.gpa! > 0);

  CgpaCalculatorProvider() {
    for (int i = 0; i < 6; i++) {
      addSemester();
    }
  }

  void addSemester() {
    _idCounter++;
    _semesters.add(SemesterModel(
      id: 'semester_$_idCounter',
      semesterNumber: _semesters.length + 1,
    ));
    notifyListeners();
  }

  void removeSemester(String id) {
    _semesters.removeWhere((s) => s.id == id);
    _renumberSemesters();
    if (_semesters.isEmpty) addSemester();
    notifyListeners();
  }

  void _renumberSemesters() {
    for (int i = 0; i < _semesters.length; i++) {
      final s = _semesters[i];
      _semesters[i] = SemesterModel(
        id: s.id,
        semesterNumber: i + 1,
        gpa: s.gpa,
      );
    }
  }

  void updateSemesterGpa(String id, double? gpa) {
    final index = _semesters.indexWhere((s) => s.id == id);
    if (index == -1) return;
    _semesters[index] = _semesters[index].copyWith(gpa: gpa);
    notifyListeners();
  }

  Future<double> calculate() async {
    final gpas = _semesters
        .where((s) => s.gpa != null && s.gpa! > 0)
        .map((s) => s.gpa!)
        .toList();

    final cgpa = GpaCalculatorUtil.calculateCgpa(gpas);
    _lastCgpa = cgpa;
    notifyListeners();

    await _persistResult(cgpa);
    return cgpa;
  }

  Future<void> _persistResult(double cgpa) async {
    final existing = _storage.getJsonList(AppStrings.keySavedCgpaResults);
    existing.add({'cgpa': cgpa});
    await _storage.setJsonList(AppStrings.keySavedCgpaResults, existing);
  }

  void reset() {
    _semesters.clear();
    _idCounter = 0;
    _lastCgpa = null;
    for (int i = 0; i < 6; i++) {
      addSemester();
    }
  }
}