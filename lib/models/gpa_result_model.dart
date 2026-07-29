/// Holds the computed output shown on the "Semester Result" / "CGPA Result"
/// screen: GPA value, credit hours, percentage, average marks, total marks.
class GpaResultModel {
  final double gpa;
  final int creditHours;
  final double percentage;
  final int totalObtainedMarks;
  final int totalPossibleMarks;

  const GpaResultModel({
    required this.gpa,
    required this.creditHours,
    required this.percentage,
    required this.totalObtainedMarks,
    required this.totalPossibleMarks,
  });

  /// Average marks shown on the "Academic Performance" section,
  /// e.g. "48.8" — same value as [percentage] in the Figma design.
  double get averageMarks => percentage;

  factory GpaResultModel.empty() => const GpaResultModel(
    gpa: 0.0,
    creditHours: 0,
    percentage: 0.0,
    totalObtainedMarks: 0,
    totalPossibleMarks: 0,
  );

  Map<String, dynamic> toJson() => {
    'gpa': gpa,
    'creditHours': creditHours,
    'percentage': percentage,
    'totalObtainedMarks': totalObtainedMarks,
    'totalPossibleMarks': totalPossibleMarks,
  };

  factory GpaResultModel.fromJson(Map<String, dynamic> json) =>
      GpaResultModel(
        gpa: (json['gpa'] as num).toDouble(),
        creditHours: json['creditHours'] as int,
        percentage: (json['percentage'] as num).toDouble(),
        totalObtainedMarks: json['totalObtainedMarks'] as int,
        totalPossibleMarks: json['totalPossibleMarks'] as int,
      );
}