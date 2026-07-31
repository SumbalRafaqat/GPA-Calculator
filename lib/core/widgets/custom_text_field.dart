import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_text_styles.dart';

/// Reusable labeled input field: "Obtained", "Total", "Credit Hours",
/// "Percentage", "GPA" fields across GPA/CGPA/Percentage screens.
class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final String? initialValue;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final bool isNumeric;
  final bool enabled;
  final String? errorText;
  final Widget? suffixIcon;
  final Widget? suffixText;

  const CustomTextField({
    super.key,
    this.label,
    this.hintText,
    this.initialValue,
    this.controller,
    this.onChanged,
    this.isNumeric = false,
    this.enabled = true,
    this.errorText,
    this.suffixIcon,
    this.suffixText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label!, style: AppTextStyles.inputLabel),
          const SizedBox(height: 6),
        ],
        TextFormField(
          controller: controller,
          initialValue: controller == null ? initialValue : null,
          onChanged: onChanged,
          enabled: enabled,
          keyboardType: isNumeric
              ? const TextInputType.numberWithOptions(decimal: true)
              : TextInputType.text,
          inputFormatters: isNumeric
              ? [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))]
              : null,
          decoration: InputDecoration(
            hintText: hintText,
            errorText: errorText,
            suffixIcon: suffixIcon,
            suffix: suffixText,
          ),
        ),
      ],
    );
  }
}