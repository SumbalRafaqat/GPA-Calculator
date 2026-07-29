/// Represents a single course row on the GPA Calculator screen:
/// Name (optional), Obtained marks, Total marks, Credit Hours.
class CourseModel {
  final String id;
  String name;
  double obtainedMarks;
  double totalMarks;
  double creditHours;

  CourseModel({
    required this.id,
    this.name = '',
    this.obtainedMarks = 0,
    this.totalMarks = 100,
    this.creditHours = 3,
  });

  CourseModel copyWith({
    String? name,
    double? obtainedMarks,
    double? totalMarks,
    double? creditHours,
  }) {
    return CourseModel(
      id: id,
      name: name ?? this.name,
      obtainedMarks: obtainedMarks ?? this.obtainedMarks,
      totalMarks: totalMarks ?? this.totalMarks,
      creditHours: creditHours ?? this.creditHours,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'obtainedMarks': obtainedMarks,
    'totalMarks': totalMarks,
    'creditHours': creditHours,
  };

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
    id: json['id'] as String,
    name: json['name'] as String? ?? '',
    obtainedMarks: (json['obtainedMarks'] as num?)?.toDouble() ?? 0,
    totalMarks: (json['totalMarks'] as num?)?.toDouble() ?? 100,
    creditHours: (json['creditHours'] as num?)?.toDouble() ?? 3,
  );
}