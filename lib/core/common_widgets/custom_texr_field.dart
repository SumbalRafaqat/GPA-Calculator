// lib/core/widgets/custom_text_field.dart
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../theme/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    Key? key,
    required this.hintText,
    this.labelText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Text(
            labelText!,
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 6),
        ],
        Container(
          height: AppDimensions.fieldHeight,
          decoration: BoxDecoration(
            color: AppColors.fieldBackground,
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            style: AppTextStyles.inputStyle,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textLight),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingMedium,
                vertical: 16.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}