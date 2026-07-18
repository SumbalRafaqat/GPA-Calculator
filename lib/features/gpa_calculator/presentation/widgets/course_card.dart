import 'package:flutter/material.dart';
import 'package:gpa_calculator/core/constants/app_dimensions.dart';
import 'package:gpa_calculator/core/theme/app_colors.dart';
import 'package:gpa_calculator/core/theme/app_text_styles.dart';
import 'package:gpa_calculator/features/gpa_calculator/data/models/course_model.dart';


/// Exact match of the Figma "Course N" card:
/// title + delete icon, Name (Optional) field, Obtained | Total split row
/// (value large / caption below), Credit Hours row (label left, value
/// right), live blue "Percentage: X%" line at the bottom once Obtained
/// has a value.
class CourseCard extends StatefulWidget {
  final int index;
  final CourseEntry course;
  final VoidCallback onChanged;
  final VoidCallback? onDelete;

  const CourseCard({
    super.key,
    required this.index,
    required this.course,
    required this.onChanged,
    this.onDelete,
  });

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _obtainedCtrl;
  late final TextEditingController _totalCtrl;
  late final TextEditingController _creditsCtrl;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.course.name);
    _obtainedCtrl = TextEditingController(text: widget.course.obtained?.toStringAsFixed(0) ?? '');
    _totalCtrl = TextEditingController(text: widget.course.total.toStringAsFixed(0));
    _creditsCtrl = TextEditingController(text: widget.course.creditHours.toStringAsFixed(0));
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _obtainedCtrl.dispose();
    _totalCtrl.dispose();
    _creditsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pct = widget.course.percentage;
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.spaceM),
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusCard),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Course ${widget.index + 1}', style: AppTextStyles.h2),
              if (widget.onDelete != null)
                InkWell(
                  onTap: widget.onDelete,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(color: AppColors.danger, borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.delete_outline, color: Colors.white, size: 18),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceS),
          TextField(
            controller: _nameCtrl,
            style: AppTextStyles.fieldInput,
            decoration: InputDecoration(
              labelText: 'Name (Optional)',
              hintText: 'Programming Fundamentals',
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: AppDimensions.spaceM, vertical: AppDimensions.spaceS),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusField), borderSide: const BorderSide(color: AppColors.cardBorder)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusField), borderSide: const BorderSide(color: AppColors.cardBorder)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusField), borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
            ),
            onChanged: (v) {
              widget.course.name = v;
              widget.onChanged();
            },
          ),
          const SizedBox(height: AppDimensions.spaceS),
          _splitValueRow(),
          const SizedBox(height: AppDimensions.spaceS),
          _creditHoursRow(),
          if (pct != null) ...[
            const SizedBox(height: AppDimensions.spaceS),
            Text('Percentage: ${pct.toStringAsFixed(1)}%',
                style: AppTextStyles.bodyBold.copyWith(color: AppColors.primary, fontSize: 13)),
          ],
        ],
      ),
    );
  }

  /// "Obtained | Total" row — big value on top, small grey caption below,
  /// separated by a vertical divider — matches Figma exactly.
  Widget _splitValueRow() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.radiusField),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: _valueCell(
                controller: _obtainedCtrl,
                hint: 'e.g.,85',
                caption: 'Obtained',
                onChanged: (v) {
                  widget.course.obtained = double.tryParse(v);
                  widget.onChanged();
                },
              ),
            ),
            const VerticalDivider(width: 1, color: AppColors.cardBorder),
            Expanded(
              child: _valueCell(
                controller: _totalCtrl,
                hint: '100',
                caption: 'Total',
                onChanged: (v) {
                  widget.course.total = double.tryParse(v) ?? 100;
                  widget.onChanged();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _valueCell({
    required TextEditingController controller,
    required String hint,
    required String caption,
    required ValueChanged<String> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.spaceS, horizontal: AppDimensions.spaceM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyBold.copyWith(fontSize: 16),
            decoration: InputDecoration(
              isDense: true,
              hintText: hint,
              hintStyle: AppTextStyles.fieldHint,
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            onChanged: onChanged,
          ),
          const SizedBox(height: 2),
          Text(caption, style: AppTextStyles.captionSmall),
        ],
      ),
    );
  }

  /// "Credit Hours" row — static label on the left, editable value right.
  Widget _creditHoursRow() {
    return Container(
      height: AppDimensions.fieldHeight,
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spaceM),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.radiusField),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        children: [
           Text('Credit Hours', style: AppTextStyles.body),
          const Spacer(),
          SizedBox(
            width: 60,
            child: TextField(
              controller: _creditsCtrl,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.right,
              style: AppTextStyles.bodyBold,
              decoration: const InputDecoration(isDense: true, border: InputBorder.none),
              onChanged: (v) {
                widget.course.creditHours = double.tryParse(v) ?? 0;
                widget.onChanged();
              },
            ),
          ),
        ],
      ),
    );
  }
}