/// Single course entry inside the GPA Calculator's course list.
class CourseEntry {
  String name;
  double? obtained;
  double total;
  double creditHours;

  CourseEntry({
    this.name = '',
    this.obtained,
    this.total = 100,
    this.creditHours = 3,
  });

  /// Live percentage shown at the bottom of each course card.
  /// Returns null until the student has typed an "Obtained" value.
  double? get percentage {
    if (obtained == null || total == 0) return null;
    return (obtained! / total) * 100;
  }

  bool get isValid => obtained != null && obtained! >= 0 && total > 0 && creditHours > 0;
}