// lib/features/gpa_calculator/data/models/course_model.dart
class Course {
  String id;
  String name;
  double? marksObtained;
  double? totalMarks;
  double creditHours;

  Course({
    required this.id,
    this.name = '',
    this.marksObtained,
    this.totalMarks = 100,
    this.creditHours = 3.0,
  });

  // Automatically calculate percentage for GPA conversion
  double get percentage {
    if (marksObtained == null || totalMarks == null || totalMarks == 0) return 0.0;
    return (marksObtained! / totalMarks!) * 100;
  }
}