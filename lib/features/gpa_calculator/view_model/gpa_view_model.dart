// lib/features/gpa_calculator/view_models/gpa_view_model.dart
import 'package:flutter/material.dart';
import '../data/models/course_model.dart';

class GpaViewModel extends ChangeNotifier {
  double _selectedScale = 4.0;
  double get selectedScale => _selectedScale;

  bool _useMarks = true;
  bool get useMarks => _useMarks;

  int _courseCount = 5;
  int get courseCount => _courseCount;

  List<Course> _courses = [];
  List<Course> get courses => _courses;

  GpaViewModel() {
    _initializeCourses();
  }

  void _initializeCourses() {
    _courses = List.generate(
      _courseCount,
          (index) => Course(id: 'course_$index', name: 'Course ${index + 1}'),
    );
  }

  void setScale(double scale) {
    _selectedScale = scale;
    notifyListeners(); // UI ko automatic rebuild karega
  }

  void toggleScoringMethod(bool val) {
    _useMarks = val;
    notifyListeners();
  }

  void setCourseCount(int count) {
    _courseCount = count;
    _initializeCourses();
    notifyListeners();
  }

  void updateCourseMarks(String id, double obtained, double total) {
    final index = _courses.indexWhere((c) => c.id == id);
    if (index != -1) {
      _courses[index].marksObtained = obtained;
      _courses[index].totalMarks = total;
      notifyListeners();
    }
  }

  double get calculatedGpa {
    if (_courses.isEmpty) return 0.0;
    double totalCredits = 0;
    double weightedGpaPoints = 0;

    for (var course in _courses) {
      totalCredits += course.creditHours;
      double singleCourseGpa = (course.percentage / 100) * _selectedScale;
      weightedGpaPoints += (singleCourseGpa * course.creditHours);
    }

    return totalCredits == 0 ? 0.0 : (weightedGpaPoints / totalCredits);
  }
}