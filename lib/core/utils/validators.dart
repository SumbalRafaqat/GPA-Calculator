/// Shared input validators used across GPA/CGPA/Percentage forms.
/// Return null when valid, or an error message string to show under
/// the field (via CustomTextField's errorText).
class Validators {
  Validators._();

  /// Validates course/subject name (optional field, but if entered,
  /// shouldn't be just whitespace).
  static String? validateCourseName(String? value) {
    if (value != null && value.trim().isEmpty && value.isNotEmpty) {
      return 'Course name cannot be only spaces';
    }
    return null;
  }

  /// Validates a numeric marks/credit-hours field is a positive number.
  static String? validatePositiveNumber(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    final parsed = double.tryParse(value);
    if (parsed == null) return 'Enter a valid number';
    if (parsed < 0) return 'Value cannot be negative';
    return null;
  }

  /// Validates obtained marks don't exceed total marks.
  static String? validateObtainedNotExceedingTotal(
      String? obtained,
      String? total,
      ) {
    final obtainedValue = double.tryParse(obtained ?? '');
    final totalValue = double.tryParse(total ?? '');
    if (obtainedValue != null &&
        totalValue != null &&
        obtainedValue > totalValue) {
      return 'Obtained marks cannot exceed total marks';
    }
    return null;
  }

  /// Validates a percentage input is between 0 and 100 (Percentage→GPA screen).
  static String? validatePercentage(String? value) {
    if (value == null || value.trim().isEmpty) return 'Percentage is required';
    final parsed = double.tryParse(value);
    if (parsed == null) return 'Enter a valid percentage';
    if (parsed < 0 || parsed > 100) return 'Percentage must be 0-100';
    return null;
  }

  /// Validates a GPA input is between 0 and maxGpa (GPA→Percentage direction).
  static String? validateGpa(String? value, {double maxGpa = 4.0}) {
    if (value == null || value.trim().isEmpty) return 'GPA is required';
    final parsed = double.tryParse(value);
    if (parsed == null) return 'Enter a valid GPA';
    if (parsed < 0 || parsed > maxGpa) {
      return 'GPA must be 0-$maxGpa';
    }
    return null;
  }

  /// Validates semester GPA entry on the CGPA Calculator screen
  /// (e.g. Semester 1: 2.25).
  static String? validateSemesterGpa(String? value) {
    if (value == null || value.trim().isEmpty) return null; // empty = skip
    final parsed = double.tryParse(value);
    if (parsed == null) return 'Enter a valid GPA';
    if (parsed < 0 || parsed > 4.0) return 'GPA must be 0-4.0';
    return null;
  }
}