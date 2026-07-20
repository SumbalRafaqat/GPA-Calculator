import 'package:flutter/material.dart';
import 'package:gpa_calculator/core/common_widgets/custom_button.dart';
import 'package:gpa_calculator/core/constants/app_dimensions.dart';
import 'package:gpa_calculator/core/theme/app_colors.dart';
import 'package:gpa_calculator/core/theme/app_text_styles.dart';


class CgpaResultScreen extends StatelessWidget {
  final double cgpa;
  final double totalCreditHours;
  final int semesterCount;

  const CgpaResultScreen({
    super.key,
    required this.cgpa,
    required this.totalCreditHours,
    required this.semesterCount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: AppColors.textPrimary),
        title: Column(
          children: [
            Text('CGPA Result', style: AppTextStyles.h2),
             Text('Cumulative GPA', style: AppTextStyles.caption),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.spaceL),
        children: [
          // ---- CGPA header ----
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: AppDimensions.spaceXL),
            decoration: BoxDecoration(
              color: AppColors.cgpaPurple,
              borderRadius: BorderRadius.circular(AppDimensions.radiusCard),
            ),
            child: Column(
              children: [
                const Text('Your CGPA', style: TextStyle(color: Colors.white70, fontSize: 16)),
                const SizedBox(height: 4),
                Text(cgpa.toStringAsFixed(2), style: AppTextStyles.displayNumber),
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.spaceM),

          // ---- Stat tiles ----
          Row(
            children: [
              Expanded(child: _statTile(Icons.school, totalCreditHours.toStringAsFixed(0), 'Total Credit Hours')),
              const SizedBox(width: AppDimensions.spaceS),
              Expanded(child: _statTile(Icons.calendar_month, '$semesterCount', 'Semesters Included')),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceL),

          // ---- Export actions ----
          Row(
            children: [
              Expanded(child: _exportChip(icon: Icons.picture_as_pdf, label: 'PDF', selected: true, onTap: () {})),
              const SizedBox(width: AppDimensions.spaceS),
              Expanded(child: _exportChip(icon: Icons.image_outlined, label: 'Image', selected: false, onTap: () {})),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceS),
          Row(
            children: [
              Expanded(child: CustomOutlineButton(label: 'Share', icon: Icons.ios_share, onPressed: () {})),
              const SizedBox(width: AppDimensions.spaceS),
              Expanded(
                child: CustomButton(
                  label: 'Download',
                  icon: Icons.download,
                  isPill: true,
                  backgroundColor: AppColors.cgpaPurple,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statTile(IconData icon, String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.spaceM),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusCard),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.cgpaPurple),
          const SizedBox(height: 6),
          Text(value, style: AppTextStyles.statValue),
          Text(label, style: AppTextStyles.caption, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _exportChip({required IconData icon, required String label, required bool selected, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
      child: Container(
        height: AppDimensions.buttonHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.cgpaPurple : AppColors.featureCardTint,
          borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: selected ? Colors.white : AppColors.textPrimary),
            const SizedBox(width: 8),
            Text(label, style: selected ? AppTextStyles.buttonLabel : AppTextStyles.buttonLabelDark),
          ],
        ),
      ),
    );
  }
}