// lib/core/widgets/custom_button.dart
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../theme/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isSecondary;
  final bool isDanger;
  final Widget? icon;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isSecondary = false,
    this.isDanger = false,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color getBgColor() {
      if (isSecondary) return AppColors.fieldBackground;
      if (isDanger) return AppColors.error;
      return AppColors.primary;
    }

    Color getTextColor() {
      if (isSecondary) return AppColors.textMain;
      return Colors.white;
    }

    return SizedBox(
      width: double.infinity,
      height: AppDimensions.buttonHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: getBgColor(),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: AppTextStyles.buttonText.copyWith(color: getTextColor()),
            ),
          ],
        ),
      ),
    );
  }
}