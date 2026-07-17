// lib/core/widgets/custom_dropdown.dart
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../theme/app_text_styles.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String labelText;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;

  const CustomDropdown({
    Key? key,
    required this.labelText,
    required this.value,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingMedium),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            color: AppColors.cardBg,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              items: items,
              onChanged: onChanged,
              icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
              isExpanded: true,
              style: AppTextStyles.inputStyle,
            ),
          ),
        ),
      ],
    );
  }
}