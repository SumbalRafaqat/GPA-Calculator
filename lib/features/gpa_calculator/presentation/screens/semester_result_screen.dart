import 'package:flutter/material.dart';
import 'package:gpa_calculator/core/common_widgets/custom_button.dart';
import 'package:gpa_calculator/core/constants/app_dimensions.dart';
import 'package:gpa_calculator/core/theme/app_colors.dart';
import 'package:gpa_calculator/core/theme/app_text_styles.dart';


/// Exact match of the "Semester Result" screen: solid-blue GPA header card,
/// Credit Hours + Percentage stat tiles, Academic Performance card
/// (Average Marks | Total), and PDF/Image/Share/Download action row.
class SemesterResultScreen extends StatelessWidget {
  final double gpa;
  final double creditHours;
  final double percentage;
  final double totalObtained;
  final double totalPossible;

  const SemesterResultScreen({
    super.key,
    required this.gpa,
    required this.creditHours,
    required this.percentage,
    required this.totalObtained,
    required this.totalPossible,
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
            Text('Semester Result', style: AppTextStyles.h2),
             Text('Semester GPA', style: AppTextStyles.caption),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.spaceL),
        children: [
          // ---- GPA header ----
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: AppDimensions.spaceXL),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(AppDimensions.radiusCard),
            ),
            child: Column(
              children: [
                const Text('Your GPA', style: TextStyle(color: Colors.white70, fontSize: 16)),
                const SizedBox(height: 4),
                Text(gpa.toStringAsFixed(2), style: AppTextStyles.displayNumber),
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.spaceM),

          // ---- Stat tiles ----
          Row(
            children: [
              Expanded(child: _statTile(Icons.school, creditHours.toStringAsFixed(0), 'Credit Hours')),
              const SizedBox(width: AppDimensions.spaceS),
              Expanded(child: _statTile(Icons.percent, percentage.toStringAsFixed(1), 'Percentage')),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceM),

          // ---- Academic performance ----
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppDimensions.spaceM),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppDimensions.radiusCard),
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: Column(
              children: [
                Align(alignment: Alignment.centerLeft, child: Text('Academic Performance', style: AppTextStyles.h2)),
                const SizedBox(height: AppDimensions.spaceM),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(percentage.toStringAsFixed(1), style: AppTextStyles.statValue.copyWith(fontSize: 20)),
                             Text('Average Marks', style: AppTextStyles.caption),
                          ],
                        ),
                      ),
                      const VerticalDivider(width: 1, color: AppColors.cardBorder),
                      Expanded(
                        child: Column(
                          children: [
                            Text('${totalObtained.toStringAsFixed(0)}/${totalPossible.toStringAsFixed(0)}',
                                style: AppTextStyles.statValue.copyWith(fontSize: 20)),
                             Text('Total', style: AppTextStyles.caption),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
                  backgroundColor: AppColors.primary,
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
          Icon(icon, color: AppColors.primary),
          const SizedBox(height: 6),
          Text(value, style: AppTextStyles.statValue),
          Text(label, style: AppTextStyles.caption),
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
          color: selected ? AppColors.primary : AppColors.featureCardTint,
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