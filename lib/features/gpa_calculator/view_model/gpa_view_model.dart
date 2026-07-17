// Add this state to your lib/features/gpa_calculator/view_models/gpa_view_model.dart

import 'package:gpa_calculator/features/gpa_calculator/data/models/smester_model.dart';

List<SemesterModel> _semesters = [];
List<SemesterModel> get semesters => _semesters;

// Dynamic cumulative GPA calculation for target flow screens
double get calculateCumulativeGpa {
  double totalPoints = 0.0;
  double totalCredits = 0.0;

  for (var semester in _semesters) {
    totalPoints += (semester.sgpa * semester.totalCreditsEarned);
    totalCredits += semester.totalCreditsEarned;
  }

  return totalCredits == 0 ? 0.0 : (totalPoints / totalCredits);
}