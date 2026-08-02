import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_text_styles.dart';

/// Hero blue card on the Semester/CGPA Result screen showing the big
/// GPA value, e.g. "Your GPA" label + "1.76" large number.
class ResultCard extends StatelessWidget {
  final String label;
  final String value;

  const ResultCard({
    super.key,
    this.label = 'Your GPA',
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: AppDimensions.spaceXl,
        horizontal: AppDimensions.spaceLg,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
      ),
      child: Column(
        children: [
          Text(label, style: AppTextStyles.resultLabel),
          const SizedBox(height: AppDimensions.spaceSm),
          Text(value, style: AppTextStyles.resultValueLarge),
        ],
      ),
    );
  }
}

/// Small white stat tile used beside ResultCard, e.g. "Credit Hours: 18",
/// "Percentage: 48.8". Two of these sit side-by-side under ResultCard.
class ResultStatTile extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const ResultStatTile({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppDimensions.spaceLg,
          horizontal: AppDimensions.spaceMd,
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: AppDimensions.iconMd),
            const SizedBox(height: AppDimensions.spaceSm),
            Text(value, style: AppTextStyles.statValue),
            const SizedBox(height: 2),
            Text(label, style: AppTextStyles.statLabel),
          ],
        ),
      ),
    );
  }
}

/// "Academic Performance" section box seen on the Result screen —
/// shows Average Marks / Total side by side inside a bordered card.
class AcademicPerformanceCard extends StatelessWidget {
  final String title;
  final String averageLabel;
  final String averageMarks;
  final String totalLabel;
  final String total;

  const AcademicPerformanceCard({
    super.key,
    required this.title,
    required this.averageLabel,
    required this.averageMarks,
    required this.totalLabel,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spaceLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyles.cardTitle),
            const SizedBox(height: AppDimensions.spaceMd),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(averageMarks, style: AppTextStyles.statValue),
                      Text(averageLabel, style: AppTextStyles.statLabel),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(total, style: AppTextStyles.statValue),
                      Text(totalLabel, style: AppTextStyles.statLabel),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}