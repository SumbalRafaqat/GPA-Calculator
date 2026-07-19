import 'package:flutter/material.dart';
import 'package:gpa_calculator/core/constants/app_dimensions.dart';
import 'package:gpa_calculator/core/theme/app_colors.dart';
import 'package:gpa_calculator/core/theme/app_text_styles.dart';
import 'package:gpa_calculator/features/gpa_calculator/data/models/semester_entry_model.dart';

/// Exact match of the "Semester N" row in the CGPA Calculator:
///  - useCreditHours OFF: single bordered "GPA" field (Material floating
///    label — hint centered when empty, label floats top-left once filled).
///  - useCreditHours ON: "GPA | Credits" split field, big value on top /
///    small caption below each side, divided by a vertical line.
class SemesterEntryCard extends StatefulWidget {
  final SemesterEntry entry;
  final bool useCreditHours;
  final VoidCallback onChanged;
  final VoidCallback? onDelete;

  const SemesterEntryCard({
    super.key,
    required this.entry,
    required this.useCreditHours,
    required this.onChanged,
    this.onDelete,
  });

  @override
  State<SemesterEntryCard> createState() => _SemesterEntryCardState();
}

class _SemesterEntryCardState extends State<SemesterEntryCard> {
  late final TextEditingController _gpaCtrl;
  late final TextEditingController _creditsCtrl;

  @override
  void initState() {
    super.initState();
    _gpaCtrl = TextEditingController(text: widget.entry.gpa?.toString() ?? '');
    _creditsCtrl = TextEditingController(text: widget.entry.credits?.toStringAsFixed(0) ?? '');
  }

  @override
  void dispose() {
    _gpaCtrl.dispose();
    _creditsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              Text(widget.entry.label, style: AppTextStyles.sectionTitle),
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
          widget.useCreditHours ? _splitField() : _gpaOnlyField(),
        ],
      ),
    );
  }

  Widget _gpaOnlyField() {
    return TextFormField(
      controller: _gpaCtrl,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      style: AppTextStyles.fieldInput,
      decoration: InputDecoration(
        labelText: 'GPA',
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: AppDimensions.spaceM, vertical: AppDimensions.spaceM),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusField), borderSide: const BorderSide(color: AppColors.cardBorder)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusField), borderSide: const BorderSide(color: AppColors.cardBorder)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusField), borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
      ),
      onChanged: (v) {
        widget.entry.gpa = double.tryParse(v);
        widget.onChanged();
      },
    );
  }

  Widget _splitField() {
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
                controller: _gpaCtrl,
                caption: 'GPA',
                onChanged: (v) {
                  widget.entry.gpa = double.tryParse(v);
                  widget.onChanged();
                },
              ),
            ),
            const VerticalDivider(width: 1, color: AppColors.cardBorder),
            Expanded(
              child: _valueCell(
                controller: _creditsCtrl,
                caption: 'Credits',
                onChanged: (v) {
                  widget.entry.credits = double.tryParse(v);
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
    required String caption,
    required ValueChanged<String> onChanged,
  }) {
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