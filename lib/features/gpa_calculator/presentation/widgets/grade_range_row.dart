import 'package:flutter/material.dart';
import 'package:gpa_calculator/core/constants/app_dimensions.dart';
import 'package:gpa_calculator/core/theme/app_colors.dart';
import 'package:gpa_calculator/core/theme/app_text_styles.dart';
import 'package:gpa_calculator/features/gpa_calculator/data/models/grade_range_model.dart';

/// Single "Min% | Grade Points" row — bordered split field (value on top,
/// caption below, divided by a vertical line) with a separate red delete
/// icon floated to the right, matching Figma exactly.
class GradeRangeRow extends StatefulWidget {
  final GradeRange range;
  final VoidCallback onChanged;
  final VoidCallback onDelete;

  const GradeRangeRow({
    super.key,
    required this.range,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  State<GradeRangeRow> createState() => _GradeRangeRowState();
}

class _GradeRangeRowState extends State<GradeRangeRow> {
  late final TextEditingController _minCtrl;
  late final TextEditingController _gradeCtrl;

  @override
  void initState() {
    super.initState();
    _minCtrl = TextEditingController(text: widget.range.minPercent.toStringAsFixed(1));
    _gradeCtrl = TextEditingController(text: widget.range.gradePoints.toStringAsFixed(1));
  }

  @override
  void dispose() {
    _minCtrl.dispose();
    _gradeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.spaceS),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimensions.radiusField),
                border: Border.all(color: AppColors.cardBorder),
              ),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(child: _cell(_minCtrl, 'Min%', (v) {
                      widget.range.minPercent = double.tryParse(v) ?? 0;
                      widget.onChanged();
                    })),
                    const VerticalDivider(width: 1, color: AppColors.cardBorder),
                    Expanded(child: _cell(_gradeCtrl, 'Grade Points', (v) {
                      widget.range.gradePoints = double.tryParse(v) ?? 0;
                      widget.onChanged();
                    })),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: AppDimensions.spaceS),
          InkWell(
            onTap: widget.onDelete,
            borderRadius: BorderRadius.circular(8),
            child: const Icon(Icons.delete_outline, color: AppColors.danger, size: 22),
          ),
        ],
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
            style: AppTextStyles.bodyBold.copyWith(fontSize: 15),
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