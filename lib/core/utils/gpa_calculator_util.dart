import '../../models/course_model.dart';
import '../../models/gpa_result_model.dart';

/// Pure calculation functions — no Flutter/state dependency, so this is
/// trivially unit-testable in isolation. Used by GpaCalculatorProvider,
/// CgpaCalculatorProvider, and PercentageGpaProvider.
class GpaCalculatorUtil {
  GpaCalculatorUtil._();

  /// Calculates semester GPA on a 4.0 scale from a list of courses.
  /// Formula: GPA = Σ(gradePoint(course) * creditHours) / Σ(creditHours)
  static GpaResultModel calculateGpa(List<CourseModel> courses) {
    final validCourses =
    courses.where((c) => c.creditHours > 0 && c.totalMarks > 0).toList();

    if (validCourses.isEmpty) {
      return GpaResultModel.empty();
    }

    double totalWeightedPoints = 0;
    double totalCreditHours = 0;
    double totalObtainedMarks = 0;
    double totalPossibleMarks = 0;

    for (final course in validCourses) {
      final percentage = (course.obtainedMarks / course.totalMarks) * 100;
      final gradePoint = _percentageToGradePoint(percentage);

      totalWeightedPoints += gradePoint * course.creditHours;
      totalCreditHours += course.creditHours;
      totalObtainedMarks += course.obtainedMarks;
      totalPossibleMarks += course.totalMarks;
    }

    final gpa = totalCreditHours == 0
        ? 0.0
        : totalWeightedPoints / totalCreditHours;
    final averagePercentage = totalPossibleMarks == 0
        ? 0.0
        : (totalObtainedMarks / totalPossibleMarks) * 100;

    return GpaResultModel(
      gpa: double.parse(gpa.toStringAsFixed(2)),
      creditHours: totalCreditHours.toInt(),
      percentage: double.parse(averagePercentage.toStringAsFixed(1)),
      totalObtainedMarks: totalObtainedMarks.toInt(),
      totalPossibleMarks: totalPossibleMarks.toInt(),
    );
  }

  /// Converts a percentage (0-100) into a 4.0-scale grade point.
  /// Standard linear breakpoints; adjust per institution if needed.
  static double _percentageToGradePoint(double percentage) {
    if (percentage >= 85) return 4.0;
    if (percentage >= 80) return 3.7;
    if (percentage >= 75) return 3.3;
    if (percentage >= 70) return 3.0;
    if (percentage >= 65) return 2.7;
    if (percentage >= 60) return 2.3;
    if (percentage >= 55) return 2.0;
    if (percentage >= 50) return 1.7;
    return 0.0;
  }

  /// Converts a raw percentage directly to GPA (Percentage → GPA screen).
  static double percentageToGpa(double percentage, {double maxGpa = 4.0}) {
    final gpa = (percentage / 100) * maxGpa;
    return double.parse(gpa.toStringAsFixed(2));
  }

  /// Converts a GPA value back to an equivalent percentage (GPA → Percentage).
  static double gpaToPercentage(double gpa, {double maxGpa = 4.0}) {
    final percentage = (gpa / maxGpa) * 100;
    return double.parse(percentage.toStringAsFixed(1));
  }

  /// Calculates CGPA as the average of entered semester GPAs.
  /// Ignores empty/invalid (0 or negative) semester entries.
  static double calculateCgpa(List<double> semesterGpas) {
    final valid = semesterGpas.where((g) => g > 0).toList();
    if (valid.isEmpty) return 0.0;
    final sum = valid.reduce((a, b) => a + b);
    return double.parse((sum / valid.length).toStringAsFixed(2));
  }
}