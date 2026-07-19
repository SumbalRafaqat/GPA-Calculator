import 'package:flutter/material.dart';
import 'package:gpa_calculator/core/constants/app_dimensions.dart';
import 'package:gpa_calculator/core/theme/app_colors.dart';
import 'package:gpa_calculator/core/theme/app_text_styles.dart';

/// Reusable "value on top / caption below" split field, divided by a
/// vertical line — the pattern Figma reuses across Course, Semester,
/// and now GPA Planner cards ("Current GPA | Earned Credits",
/// "Target GPA | Planned Credits").
class LabeledSplitField extends StatelessWidget {
  final TextEditingController leftController;
  final TextEditingController rightController;
  final String leftCaption;
  final String rightCaption;
  final ValueChanged<String> onLeftChanged;
  final ValueChanged<String> onRightChanged;

  const LabeledSplitField({
    super.key,
    required this.leftController,
    required this.rightController,
    required this.leftCaption,
    required this.rightCaption,
    required this.onLeftChanged,
    required this.onRightChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.radiusField),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(child: _cell(leftController, leftCaption, onLeftChanged)),
            const VerticalDivider(width: 1, color: AppColors.cardBorder),
            Expanded(child: _cell(rightController, rightCaption, onRightChanged)),
          ],
        ),
      ),
    );
  }

  Widget _cell(TextEditingController controller, String caption, ValueChanged<String> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.spaceS, horizontal: AppDimensions.spaceM),
      child: Column(
        children: [
          TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyBold.copyWith(fontSize: 16),
            decoration: const InputDecoration(isDense: true, border: InputBorder.none, contentPadding: EdgeInsets.zero),
            onChanged: onChanged,
          ),
          const SizedBox(height: 2),
          Text(caption, style: AppTextStyles.captionSmall),
        ],
      ),
    );
  }
}