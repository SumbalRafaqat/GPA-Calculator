import 'package:flutter/material.dart';
import 'package:gpa_calculator/views/gpa_percentage/gpa_percentage_screen.dart';
import 'package:gpa_calculator/views/settings/setting_screen.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../core/widgets/feature_card.dart';
import '../gpa_calculator/gpa_calculator_screen.dart';
import '../cgpa_calculator/cgpa_calculator_screen.dart';
import '../percentage_gpa/percentage_gpa_screen.dart';

/// Home / Dashboard screen. Matches Figma: title + subtitle, blue hero
/// card ("Let's achieve your academic goals."), "FEATURES" label, and
/// 3 tappable feature cards routing to each calculator.
///
/// NOTE: this screen uses only built-in Material icons (Icons.*) — no
/// Image.asset calls — so it has no dependency on any asset file being
/// registered in pubspec.yaml. This avoids the "broken image / X" crash.
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Dashboard',
        subtitle: 'Track your academic performance',
        showBackButton: false,
        trailing: SettingsIconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _HeroCard(),
            const SizedBox(height: AppDimensions.spaceXl),
            const _SectionLabel(label: 'FEATURES'),
            const SizedBox(height: AppDimensions.spaceMd),
            FeatureCard(
              icon: Icons.calculate_outlined,
              iconColor: AppColors.gpaIconColor,
              iconBackgroundColor: AppColors.gpaIconBg,
              title: 'GPA Calculator',
              subtitle: 'Semester GPA',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const GpaCalculatorScreen()),
              ),
            ),
            FeatureCard(
              icon: Icons.school_outlined,
              iconColor: AppColors.cgpaIconColor,
              iconBackgroundColor: AppColors.cgpaIconBg,
              title: 'CGPA Calculator',
              subtitle: 'Cumulative GPA',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (_) => const CgpaCalculatorScreen()),
              ),
            ),
            FeatureCard(
              icon: Icons.percent_outlined,
              iconColor: AppColors.percentageIconColor,
              iconBackgroundColor: AppColors.percentageIconBg,
              title: 'Percentage to GPA',
              subtitle: 'Convert % and GPA',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (_) => const PercentageGpaScreen()),
              ),
            ),
            FeatureCard(
              icon: Icons.swap_horiz_outlined,
              iconColor: AppColors.percentageIconColor,
              iconBackgroundColor: AppColors.percentageIconBg,
              title: 'GPA to Percentage',
              subtitle: 'Convert GPA and %',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (_) => const GpaToPercentageScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Blue rounded hero card with the motivational message and a small
/// icon tile on the right — matches the Figma Dashboard card.
class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.spaceLg),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              "Let's achieve your\nacademic goals.",
              style: AppTextStyles.heroCardText,
            ),
          ),
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
            ),
            child: const Icon(
              Icons.assignment_turned_in_outlined,
              color: AppColors.primary,
              size: AppDimensions.iconLg,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: AppTextStyles.cardSubtitle.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(width: AppDimensions.spaceSm),
        const Expanded(
          child: Divider(color: AppColors.border, thickness: 1),
        ),
      ],
    );
  }
}