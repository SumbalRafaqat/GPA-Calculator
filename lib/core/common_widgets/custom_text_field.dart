import 'package:flutter/material.dart';
import 'package:gpa_calculator/core/constants/app_dimensions.dart';
import 'package:gpa_calculator/core/theme/app_colors.dart';
import 'package:gpa_calculator/core/theme/app_text_styles.dart';

/// Rounded text field matching the Percentage/GPA, Course, and Semester
/// inputs seen across the final UI — light border, no heavy fill, optional
/// floating label above and a suffix (e.g. "%", dropdown arrow).
class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final String? initialValue;
  final TextInputType keyboardType;
  final Widget? suffix;
  final ValueChanged<String>? onChanged;
  final bool enabled;

  const CustomTextField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.initialValue,
    this.keyboardType = TextInputType.text,
    this.suffix,
    this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label!, style: AppTextStyles.fieldLabel),
          const SizedBox(height: AppDimensions.spaceXXS),
        ],
        TextFormField(
          controller: controller,
          initialValue: controller == null ? initialValue : null,
          keyboardType: keyboardType,
          enabled: enabled,
          onChanged: onChanged,
          style: AppTextStyles.fieldInput,
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: suffix,
            filled: true,
            fillColor: enabled ? Colors.white : AppColors.chipInactiveBg.withOpacity(0.3),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.spaceM,
              vertical: AppDimensions.spaceM,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusField),
              borderSide: const BorderSide(color: AppColors.cardBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusField),
              borderSide: const BorderSide(color: AppColors.cardBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusField),
              borderSide: const BorderSide(color: AppColors.primary, width: AppDimensions.borderWidthSelected),
            ),
          ),
        ),
      ],
    );
  }
}

/// Split field — two inputs separated by a vertical divider, matching
/// "Current GPA | Earned Credits" and "GPA | Credits" rows.
class CustomSplitField extends StatelessWidget {
  final String leftHint;
  final String rightHint;
  final ValueChanged<String> onLeftChanged;
  final ValueChanged<String> onRightChanged;
  final TextInputType keyboardType;

  const CustomSplitField({
    super.key,
    required this.leftHint,
    required this.rightHint,
    required this.onLeftChanged,
    required this.onRightChanged,
    this.keyboardType = TextInputType.number,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.radiusField),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              keyboardType: keyboardType,
              onChanged: onLeftChanged,
              style: AppTextStyles.fieldInput,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: leftHint,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: AppDimensions.spaceM),
              ),
            ),
          ),
          Container(width: 1, height: 28, color: AppColors.cardBorder),
          Expanded(
            child: TextField(
              keyboardType: keyboardType,
              onChanged: onRightChanged,
              style: AppTextStyles.fieldInput,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: rightHint,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: AppDimensions.spaceM),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Rounded dropdown — "Select your department", "Semester", "Select Template".
class CustomDropdownField<T> extends StatelessWidget {
  final String hint;
  final T? value;
  final List<T> items;
  final String Function(T) itemLabel;
  final ValueChanged<T?> onChanged;

  const CustomDropdownField({
    super.key,
    required this.hint,
    required this.value,
    required this.items,
    required this.itemLabel,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      isExpanded: true,
      icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
      style: AppTextStyles.fieldInput,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: AppDimensions.spaceM, vertical: AppDimensions.spaceM),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusField),
          borderSide: const BorderSide(color: AppColors.cardBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusField),
          borderSide: const BorderSide(color: AppColors.cardBorder),
        ),
      ),
      items: items.map((e) => DropdownMenuItem(value: e, child: Text(itemLabel(e)))).toList(),
      onChanged: onChanged,
    );
  }
}