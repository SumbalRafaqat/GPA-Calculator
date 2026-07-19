/// Single semester row inside the CGPA Calculator's semester list.
class SemesterEntry {
  final String label; // "Semester 1", "Semester 2", ...
  double? gpa;
  double? credits;

  SemesterEntry({required this.label, this.gpa, this.credits});

  bool isValid(bool useCreditHours) {
    if (gpa == null || gpa! < 0) return false;
    if (useCreditHours && (credits == null || credits! <= 0)) return false;
    return true;
  }
}