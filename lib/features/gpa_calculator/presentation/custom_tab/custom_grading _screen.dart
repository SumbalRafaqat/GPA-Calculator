import 'package:flutter/material.dart';
import 'package:gpa_calculator/core/common_widgets/custom_button.dart';
import 'package:gpa_calculator/core/common_widgets/custom_card.dart';
import 'package:gpa_calculator/core/constants/app_dimensions.dart';
import 'package:gpa_calculator/core/theme/app_colors.dart';
import 'package:gpa_calculator/core/theme/app_text_styles.dart';
import 'package:gpa_calculator/features/gpa_calculator/data/models/grade_range_model.dart';
import 'package:gpa_calculator/features/gpa_calculator/presentation/widgets/grade_range_row.dart';


class CustomGradingScreen extends StatefulWidget {
  const CustomGradingScreen({super.key});

  @override
  State<CustomGradingScreen> createState() => _CustomGradingScreenState();
}

class _CustomGradingScreenState extends State<CustomGradingScreen> {
  bool _marksBased = true;
  double _gpaScale = 4.0;
  String _selectedTemplate = 'Default';
  bool _showAll = false;

  List<GradeRange> _ranges = defaultGradeRanges();

  static const _scales = [4.0, 5.0, 10.0];
  static const _templates = ['Default', 'Strict Grading', 'Lenient Grading'];

  List<GradeRange> get _visibleRanges => _showAll ? _ranges : _ranges.take(6).toList();

  void _addRange() {
    setState(() => _ranges.add(GradeRange(minPercent: 0, gradePoints: 0)));
  }

  void _deleteRange(int index) {
    setState(() => _ranges.removeAt(index));
  }

  void _save() {
    showDialog(
      context: context,
      builder: (_) => _StatusDialog(
        color: AppColors.primary,
        title: 'Success',
        message: 'GPA ranges have been saved successfully!',
      ),
    );
  }

  void _reset() {
    setState(() => _ranges = defaultGradeRanges());
    showDialog(
      context: context,
      builder: (_) => _StatusDialog(
        color: AppColors.danger,
        title: 'Reset Complete',
        message: 'Grade system reset to default values.',
      ),
    );
  }

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
            Text('GPA Calculator', style: AppTextStyles.h2),
            Text('Semester GPA', style: AppTextStyles.caption),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.spaceL),
        children: [
          Text('Custom Grading Settings', style: AppTextStyles.h1),
          const SizedBox(height: AppDimensions.spaceM),
          CustomSegmentedButton(
            leftLabel: 'Marks-Based',
            rightLabel: 'Grade-Based',
            isLeftSelected: _marksBased,
            onChanged: (v) => setState(() => _marksBased = v),
          ),
          const SizedBox(height: AppDimensions.spaceM),

          // ---- GPA Scale ----
          CustomCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('GPA Scale', style: AppTextStyles.sectionTitle),
                Text('Choose the GPA scale used by your institution', style: AppTextStyles.caption),
                const SizedBox(height: AppDimensions.spaceM),
                Text('GPA Scale', style: AppTextStyles.body),
                const SizedBox(height: AppDimensions.spaceS),
                Wrap(
                  spacing: AppDimensions.spaceS,
                  children: _scales.map((s) {
                    final selected = _gpaScale == s;
                    return CustomChip(label: s.toStringAsFixed(1), selected: selected, onTap: () => setState(() => _gpaScale = s));
                  }).toList(),
                ),
              ],
            ),
          ),

          // ---- Template ----
          CustomCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Template', style: AppTextStyles.h2),
                Text('GPA Range Templates', style: AppTextStyles.caption),
                const SizedBox(height: AppDimensions.spaceM),
                DropdownButtonFormField<String>(
                  value: _selectedTemplate,
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
                  style: AppTextStyles.fieldInput,
                  decoration: InputDecoration(
                    labelText: 'Select Template',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: AppDimensions.spaceM, vertical: AppDimensions.spaceM),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusField), borderSide: const BorderSide(color: AppColors.cardBorder)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusField), borderSide: const BorderSide(color: AppColors.cardBorder)),
                  ),
                  items: _templates.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                  onChanged: (v) => setState(() => _selectedTemplate = v ?? _selectedTemplate),
                ),
              ],
            ),
          ),

          // ---- GPA Ranges ----
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('GPA Ranges', style: AppTextStyles.sectionTitle),
              InkWell(
                onTap: _addRange,
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(color: AppColors.chipInactiveBg, shape: BoxShape.circle),
                  child: const Icon(Icons.add, color: AppColors.textPrimary, size: 18),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceM),
          ...List.generate(_visibleRanges.length, (i) {
            return GradeRangeRow(
              range: _visibleRanges[i],
              onChanged: () => setState(() {}),
              onDelete: () => _deleteRange(i),
            );
          }),
          if (_ranges.length > 6)
            Center(
              child: TextButton.icon(
                onPressed: () => setState(() => _showAll = !_showAll),
                icon: Icon(_showAll ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: AppColors.primary),
                label: Text(
                  _showAll ? 'Show less' : 'Show ${_ranges.length - 6} more ranges',
                  style: AppTextStyles.bodyBold.copyWith(color: AppColors.primary),
                ),
              ),
            ),
          const SizedBox(height: AppDimensions.spaceM),

          // ---- Reset / Save ----
          Row(
            children: [
              Expanded(
                child: CustomButton.danger(
                  label: 'Reset',
                  onPressed: _reset,
                ),
              ),
              const SizedBox(width: AppDimensions.spaceS),
              Expanded(
                child: CustomButton(
                  label: 'Save',
                  icon: Icons.save_outlined,
                  isPill: false,
                  backgroundColor: AppColors.primary,
                  onPressed: _save,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Shared "Success" / "Reset Complete" confirmation dialog.
class _StatusDialog extends StatelessWidget {
  final Color color;
  final String title;
  final String message;

  const _StatusDialog({required this.color, required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusCard)),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spaceL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: const Icon(Icons.check, color: Colors.white, size: 30),
            ),
            const SizedBox(height: AppDimensions.spaceM),
            Text(title, style: AppTextStyles.h2),
            const SizedBox(height: AppDimensions.spaceXS),
            Text(message, style: AppTextStyles.caption, textAlign: TextAlign.center),
            const SizedBox(height: AppDimensions.spaceL),
            CustomButton(
              label: 'OK',
              isPill: false,
              backgroundColor: color,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}