import 'package:flutter/material.dart';
import 'package:gpa_calculator/core/constants/app_dimensions.dart';
import 'package:gpa_calculator/core/theme/app_colors.dart';
import 'package:gpa_calculator/core/theme/app_text_styles.dart';


/// Dashboard feature row — "GPA Calculator", "CGPA Calculator", etc.
/// Light lavender-pink card, colored square icon, outlined circular
/// arrow on the right matching the feature's accent color.
class FeatureCard extends StatelessWidget {
  final IconData icon;
  final Color accentColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.accentColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusCard),
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.spaceM),
        decoration: BoxDecoration(
          color: AppColors.featureCardTint,
          borderRadius: BorderRadius.circular(AppDimensions.radiusCard),
        ),
        child: Row(
          children: [
            Container(
              width: AppDimensions.iconBoxSize,
              height: AppDimensions.iconBoxSize,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(AppDimensions.radiusIcon),
              ),
              child: Icon(icon, color: Colors.white, size: AppDimensions.iconL),
            ),
            const SizedBox(width: AppDimensions.spaceM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.h2.copyWith(fontSize: 15)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: AppTextStyles.caption),
                ],
              ),
            ),
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: accentColor, width: 1.4),
              ),
              child: Icon(Icons.arrow_forward, color: accentColor, size: 16),
            ),
          ],
        ),
      ),
    );
  }
}