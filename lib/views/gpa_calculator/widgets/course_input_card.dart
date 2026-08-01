import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../models/course_model.dart';
import '../../../l10n/app_localizations.dart';

/// One "Course N" card on the GPA Calculator screen — matches Figma:
/// header row (title + delete icon), Name field, Obtained/Total side
/// by side, Credit Hours field.
class CourseInputCard extends StatelessWidget {
  final int index;
  final CourseModel course;
  final ValueChanged<String> onNameChanged;
  final ValueChanged<String> onObtainedChanged;
  final ValueChanged<String> onTotalChanged;
  final ValueChanged<String> onCreditHoursChanged;
  final VoidCallback onDelete;

  const CourseInputCard({
    super.key,
    required this.index,
    required this.course,
    required this.onNameChanged,
    required this.onObtainedChanged,
    required this.onTotalChanged,
    required this.onCreditHoursChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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
                Text(l10n.courseLabel(index), style: AppTextStyles.cardTitle),
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
              label: l10n.courseName,
              hintText: 'Programming Fundamentals',
              initialValue: course.name,
              onChanged: onNameChanged,
            ),
            const SizedBox(height: AppDimensions.spaceMd),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    label: l10n.obtained,
                    hintText: 'e.g. 85',
                    isNumeric: true,
                    initialValue: course.obtainedMarks == 0
                        ? ''
                        : course.obtainedMarks.toString(),
                    onChanged: onObtainedChanged,
                  ),
                ),
                const SizedBox(width: AppDimensions.spaceMd),
                Expanded(
                  child: CustomTextField(
                    label: l10n.total,
                    hintText: '100',
                    isNumeric: true,
                    initialValue: course.totalMarks.toString(),
                    onChanged: onTotalChanged,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.spaceMd),
            CustomTextField(
              label: l10n.creditHours,
              hintText: '3',
              isNumeric: true,
              initialValue: course.creditHours.toString(),
              onChanged: onCreditHoursChanged,
            ),
          ],
        ),
      ),
    );
  }
}