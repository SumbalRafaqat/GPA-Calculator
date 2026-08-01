import 'package:flutter/material.dart';
import 'package:gpa_calculator/views/gpa_percentage/gpa_percentage_screen.dart';
import 'package:gpa_calculator/views/settings/setting_screen.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../core/widgets/feature_card.dart';
import '../../l10n/app_localizations.dart';
import '../gpa_calculator/gpa_calculator_screen.dart';
import '../cgpa_calculator/cgpa_calculator_screen.dart';
import '../percentage_gpa/percentage_gpa_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.dashboardTitle,
        subtitle: l10n.dashboardSubtitle,
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
            _HeroCard(text: l10n.dashboardHeroText),
            const SizedBox(height: AppDimensions.spaceXl),
            _SectionLabel(label: l10n.featuresLabel),
            const SizedBox(height: AppDimensions.spaceMd),
            FeatureCard(
              icon: Icons.calculate_outlined,
              iconColor: AppColors.gpaIconColor,
              iconBackgroundColor: AppColors.gpaIconBg,
              title: l10n.featureGpaTitle,
              subtitle: l10n.featureGpaSubtitle,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const GpaCalculatorScreen()),
              ),
            ),
            FeatureCard(
              icon: Icons.school_outlined,
              iconColor: AppColors.cgpaIconColor,
              iconBackgroundColor: AppColors.cgpaIconBg,
              title: l10n.featureCgpaTitle,
              subtitle: l10n.featureCgpaSubtitle,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const CgpaCalculatorScreen()),
              ),
            ),
            FeatureCard(
              icon: Icons.percent_outlined,
              iconColor: AppColors.percentageIconColor,
              iconBackgroundColor: AppColors.percentageIconBg,
              title: l10n.featurePercentageTitle,
              subtitle: l10n.featurePercentageSubtitle,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const PercentageGpaScreen()),
              ),
            ),
            FeatureCard(
              icon: Icons.swap_horiz_outlined,
              iconColor: AppColors.percentageIconColor,
              iconBackgroundColor: AppColors.percentageIconBg,
              title: l10n.gpaToPercentageTitle,
              subtitle: l10n.gpaToPercentageSubtitle,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const GpaToPercentageScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  final String text;
  const _HeroCard({required this.text});

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
          Expanded(
            child: Text(text, style: AppTextStyles.heroCardText),
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