import 'package:flutter/material.dart';
import 'package:gpa_calculator/core/constants/app_dimensions.dart';
import 'package:gpa_calculator/core/theme/app_colors.dart';
import 'package:gpa_calculator/core/theme/app_text_styles.dart';


/// "Courses (6) / Input Type: manual" row with a circular "+" add button —
/// matches the Group 4207/4208 asset that sits above the course card list.
class CoursesHeader extends StatelessWidget {
  final int count;
  final String inputType; // 'manual' | 'template'
  final VoidCallback onAdd;

  const CoursesHeader({
    super.key,
    required this.count,
    required this.inputType,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spaceM, vertical: AppDimensions.spaceS),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusCard),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        children: [
          const Icon(Icons.menu_book_outlined, color: AppColors.textPrimary, size: AppDimensions.iconL),
          const SizedBox(width: AppDimensions.spaceS),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Courses ($count)', style: AppTextStyles.h2.copyWith(fontSize: 16)),
                Text('Input Type: $inputType', style: AppTextStyles.caption),
              ],
            ),
          ),
          InkWell(
            onTap: onAdd,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 34,
              height: 34,
              decoration: const BoxDecoration(color: AppColors.chipInactiveBg, shape: BoxShape.circle),
              child: const Icon(Icons.add, color: AppColors.textPrimary, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}