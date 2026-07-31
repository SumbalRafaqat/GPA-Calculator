import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../models/semester_model.dart';

/// One "Semester N" card on the CGPA Calculator screen — matches
/// Figma: "Semester 1" label (primary color), single GPA input field,
/// delete icon top-right.
class SemesterInputCard extends StatelessWidget {
  final SemesterModel semester;
  final ValueChanged<String> onGpaChanged;
  final VoidCallback onDelete;

  const SemesterInputCard({
    super.key,
    required this.semester,
    required this.onGpaChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppDimensions.spaceLg),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spaceLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Semester ${semester.semesterNumber}',
                  style: AppTextStyles.cardTitle.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                InkWell(
                  onTap: onDelete,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
                  child: const Padding(
                    padding: EdgeInsets.all(AppDimensions.spaceXs),
                    child: Icon(
                      Icons.delete_outline,
                      size: AppDimensions.iconSm,
                      color: AppColors.deleteRed,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.spaceMd),
            CustomTextField(
              label: 'GPA',
              hintText: 'e.g. 2.25',
              isNumeric: true,
              initialValue: semester.gpa?.toString() ?? '',
              onChanged: onGpaChanged,
            ),
          ],
        ),
      ),
    );
  }
}