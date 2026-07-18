import 'package:flutter/material.dart';
import 'package:gpa_calculator/core/constants/app_dimensions.dart';
import 'package:gpa_calculator/core/theme/app_colors.dart';


/// White, rounded, light-bordered section container used for every
/// grouped block across the app (Configuration, Input Method, Semester N, etc.)
class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  const CustomCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppDimensions.spaceM),
    this.margin = const EdgeInsets.only(bottom: AppDimensions.spaceM),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusCard),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: child,
    );
  }
}