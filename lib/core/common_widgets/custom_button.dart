import 'package:flutter/material.dart';
import 'package:gpa_calculator/core/constants/app_dimensions.dart';
import 'package:gpa_calculator/core/theme/app_colors.dart';
import 'package:gpa_calculator/core/theme/app_text_styles.dart';



class CustomButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final bool isPill;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.label,
    this.icon,
    required this.onPressed,
    this.backgroundColor = AppColors.darkActionButton,
    this.isPill = true,
    this.isLoading = false,
  });
  const CustomButton.danger({
    super.key,
    required this.label,
    this.icon = Icons.restore,
    required this.onPressed,
    this.isPill = false,
    this.isLoading = false,
  }) : backgroundColor = AppColors.danger;

  const CustomButton.primary({
    super.key,
    required this.label,
    this.icon,
    required this.onPressed,
    this.isPill = false,
    this.isLoading = false,
  }) : backgroundColor = AppColors.primary;

  @override
  Widget build(BuildContext context) {
    final disabled = onPressed == null || isLoading;
    return SizedBox(
      width: double.infinity,
      height: AppDimensions.buttonHeight,
      child: ElevatedButton(
        onPressed: disabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: disabled ? AppColors.chipInactiveBg : backgroundColor,
          disabledBackgroundColor: backgroundColor.withOpacity(0.5),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isPill ? AppDimensions.radiusPill : AppDimensions.radiusButton),
          ),
        ),
        child: isLoading
            ? const SizedBox(
          width: 22, height: 22,
          child: CircularProgressIndicator(strokeWidth: 2.4, color: Colors.white),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.white, size: AppDimensions.iconS),
              ),
              const SizedBox(width: AppDimensions.spaceS),
            ],
            Text(label, style: AppTextStyles.buttonLabel),
          ],
        ),
      ),
    );
  }
}


class CustomSegmentedButton extends StatelessWidget {
  final String leftLabel;
  final String rightLabel;
  final bool isLeftSelected;
  final ValueChanged<bool> onChanged;

  const CustomSegmentedButton({
    super.key,
    required this.leftLabel,
    required this.rightLabel,
    required this.isLeftSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _segment(leftLabel, isLeftSelected, () => onChanged(true))),
        const SizedBox(width: AppDimensions.spaceS),
        Expanded(child: _segment(rightLabel, !isLeftSelected, () => onChanged(false))),
      ],
    );
  }

  Widget _segment(String label, bool selected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusButton),
      child: Container(
        height: AppDimensions.buttonHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.chipSelectedBg : AppColors.chipInactiveBg,
          borderRadius: BorderRadius.circular(AppDimensions.radiusButton),
        ),
        child: Text(
          label,
          style: selected
              ? AppTextStyles.buttonLabel
              : AppTextStyles.buttonLabelDark.copyWith(color: AppColors.chipInactiveText),
        ),
      ),
    );
  }
}

class CustomChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const CustomChip({super.key, required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusChip),
      child: Container(
        width: AppDimensions.chipSize,
        height: AppDimensions.chipSize,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryLight : Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.cardBorder,
            width: selected ? AppDimensions.borderWidthSelected : AppDimensions.borderWidth,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.bodyBold.copyWith(color: selected ? AppColors.primary : AppColors.textPrimary),
        ),
      ),
    );
  }
}

class CustomOutlineButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const CustomOutlineButton({super.key, required this.label, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.buttonHeight,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          side: const BorderSide(color: AppColors.cardBorder),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusButton)),
        ),
        icon: Icon(icon, size: AppDimensions.iconM),
        label: Text(label, style: AppTextStyles.buttonLabelDark),
      ),
    );
  }
}