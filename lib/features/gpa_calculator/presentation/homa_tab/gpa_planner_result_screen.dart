import 'package:flutter/material.dart';
import 'package:gpa_calculator/core/constants/app_dimensions.dart';
import 'package:gpa_calculator/core/theme/app_colors.dart';
import 'package:gpa_calculator/core/theme/app_text_styles.dart';

/// "GPA Planner Result" screen — matches Figma exactly: Current/Target GPA
/// stat tiles, Credit Hours breakdown card (Completed/Planned/Total), and
/// an achievable (green) or not-achievable (red) status banner.
class GpaPlannerResultScreen extends StatelessWidget {
  final double currentGpa;
  final double targetGpa;
  final double completedCredits;
  final double plannedCredits;
  final double? requiredGpa; // null when it can't be computed
  final bool achievable;
  final double gpaScale;

  const GpaPlannerResultScreen({
    super.key,
    required this.currentGpa,
    required this.targetGpa,
    required this.completedCredits,
    required this.plannedCredits,
    required this.requiredGpa,
    required this.achievable,
    required this.gpaScale,
  });

  double get _totalCredits => completedCredits + plannedCredits;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: AppColors.textPrimary),
        title:  Column(
          children: [
            Text('GPA Planner Result', style: AppTextStyles.h2),
            Text('Plan Target GPA', style: AppTextStyles.caption),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.spaceL),
        children: [
          // ---- Stat tiles ----
          Row(
            children: [
              Expanded(child: _statTile(Icons.school, currentGpa.toStringAsFixed(2), 'Current GPA')),
              const SizedBox(width: AppDimensions.spaceS),
              Expanded(child: _statTile(Icons.flag, targetGpa.toStringAsFixed(1), 'Target GPA')),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceM),

          // ---- Credit Hours ----
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppDimensions.spaceM),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppDimensions.radiusCard),
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(alignment: Alignment.center, child: Text('Credit Hours', style: AppTextStyles.h2)),
                const SizedBox(height: AppDimensions.spaceM),
                _row('Completed Credits', completedCredits.toStringAsFixed(0)),
                const SizedBox(height: AppDimensions.spaceXS),
                _row('Planned Credits', plannedCredits.toStringAsFixed(0)),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppDimensions.spaceS),
                  child: Divider(height: 1, color: AppColors.divider),
                ),
                _row('Total Credits', _totalCredits.toStringAsFixed(0), bold: true),
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.spaceM),

          // ---- Status banner ----
          if (achievable)
            _banner(
              color: AppColors.success,
              icon: Icons.check_circle,
              title: 'Target Achievable',
              message: requiredGpa == null
                  ? 'You are on track to hit your target GPA.'
                  : 'You need ${requiredGpa!.toStringAsFixed(2)} GPA in your remaining credits.',
            )
          else
            _banner(
              color: AppColors.danger,
              icon: Icons.warning_amber_rounded,
              title: 'Target Not Achievable',
              message: requiredGpa == null
                  ? 'Add planned credits to calculate what is required.'
                  : 'Required GPA (${requiredGpa!.toStringAsFixed(2)}) exceeds maximum possible.',
            ),
        ],
      ),
    );
  }

  Widget _row(String label, String value, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: bold ? AppTextStyles.bodyBold : AppTextStyles.caption),
        Text(value, style: bold ? AppTextStyles.h2.copyWith(fontSize: 16) : AppTextStyles.body),
      ],
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

  Widget _banner({required Color color, required IconData icon, required String title, required String message}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(AppDimensions.radiusCard)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: AppDimensions.spaceS),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
                const SizedBox(height: 2),
                Text(message, style: const TextStyle(color: Colors.white, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}