/// Single Min% → Grade Points row inside Custom Grading Settings.
class GradeRange {
  double minPercent;
  double gradePoints;

  GradeRange({required this.minPercent, required this.gradePoints});
}

/// Default seed ranges shown before the user edits/saves their own —
/// matches the flat "85.0 / 4.0" placeholder rows visible in Figma.
List<GradeRange> defaultGradeRanges() => List.generate(
  37,
      (_) => GradeRange(minPercent: 85.0, gradePoints: 4.0),
);