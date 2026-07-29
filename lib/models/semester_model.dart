/// Represents a single semester row on the CGPA Calculator screen
/// (e.g. "Semester 1" → GPA: 2.25), used to compute cumulative CGPA.
class SemesterModel {
  final String id;
  final int semesterNumber; // display label, e.g. 1 for "Semester 1"
  double? gpa; // null/empty until user types a value

  SemesterModel({
    required this.id,
    required this.semesterNumber,
    this.gpa,
  });

  SemesterModel copyWith({double? gpa}) {
    return SemesterModel(
      id: id,
      semesterNumber: semesterNumber,
      gpa: gpa ?? this.gpa,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'semesterNumber': semesterNumber,
    'gpa': gpa,
  };

  factory SemesterModel.fromJson(Map<String, dynamic> json) => SemesterModel(
    id: json['id'] as String,
    semesterNumber: json['semesterNumber'] as int,
    gpa: (json['gpa'] as num?)?.toDouble(),
  );
}