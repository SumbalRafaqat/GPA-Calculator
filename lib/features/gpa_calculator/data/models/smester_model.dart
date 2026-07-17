// lib/features/gpa_calculator/data/models/semester_model.dart
import 'course_model.dart';

class SemesterModel {
  final String id;
  final String name;             // e.g., "Semester 1", "Semester 2"
  final List<Course> courses;    // List of courses within this semester
  double? manualGpa;             // Agar user "Manual Entry" toggle select kare (Figma screenshot key mutabiq)
  double creditHours;            // Allocated credit hours for this semester

  SemesterModel({
    required this.id,
    required this.name,
    this.courses = const [],
    this.manualGpa,
    this.creditHours = 18.0,      // Default standard credit hours allocation
  });

  /// 1. Calculate SGPA (Semester GPA) based on courses or manual entry
  double get sgpa {
    // Agar user manual entry use kar raha hai
    if (manualGpa != null) {
      return manualGpa!;
    }

    // Agar courses list khali hai
    if (courses.isEmpty) return 0.0;

    double totalCredits = 0.0;
    double weightedPoints = 0.0;

    for (var course in courses) {
      totalCredits += course.creditHours;
      // Linear mapping logic (Percentage to dynamic GPA)
      // Standard local scale: 85%+ = 4.0, 80% = 3.66, etc.
      double courseGpa = _convertPercentToGpa(course.percentage);
      weightedPoints += (courseGpa * course.creditHours);
    }

    return totalCredits == 0 ? 0.0 : (weightedPoints / totalCredits);
  }

  /// 2. Total Credit Hours actually completed/assigned in this semester
  double get totalCreditsEarned {
    if (courses.isEmpty) {
      return creditHours; // Fallback to manual semester credit hours if courses are empty
    }
    return courses.fold(0.0, (sum, course) => sum + course.creditHours);
  }

  /// 3. Helper conversion logic following Pakistani Universities' Standard Grading System
  double _convertPercentToGpa(double percentage) {
    if (percentage >= 85.0) return 4.00;
    if (percentage >= 80.0) return 3.66;
    if (percentage >= 75.0) return 3.33;
    if (percentage >= 71.0) return 3.00;
    if (percentage >= 68.0) return 2.66;
    if (percentage >= 64.0) return 2.33;
    if (percentage >= 61.0) return 2.00;
    if (percentage >= 58.0) return 1.66;
    if (percentage >= 50.0) return 1.00;
    return 0.00; // Fail state
  }

  /// CopyWith method to update the model immutably in ViewModels
  SemesterModel copyWith({
    String? id,
    String? name,
    List<Course>? courses,
    double? manualGpa,
    double? creditHours,
  }) {
    return SemesterModel(
      id: id ?? this.id,
      name: name ?? this.name,
      courses: courses ?? this.courses,
      manualGpa: manualGpa ?? this.manualGpa,
      creditHours: creditHours ?? this.creditHours,
    );
  }
}