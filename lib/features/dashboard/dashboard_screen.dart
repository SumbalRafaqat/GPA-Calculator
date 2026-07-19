import 'package:flutter/material.dart';
import 'package:gpa_calculator/core/common_widgets/app_botton_nav.dart';
import 'package:gpa_calculator/core/common_widgets/feature_card.dart';
import 'package:gpa_calculator/core/constants/app_dimensions.dart';
import 'package:gpa_calculator/core/theme/app_colors.dart';
import 'package:gpa_calculator/core/theme/app_text_styles.dart';
import 'package:gpa_calculator/features/gpa_calculator/presentation/homa_tab/cgpa_calculator_screen.dart';
import 'package:gpa_calculator/features/gpa_calculator/presentation/homa_tab/gpa_calculator_screen.dart';
import 'package:gpa_calculator/features/gpa_calculator/presentation/homa_tab/gpa_planner_config_screen.dart';
import 'package:gpa_calculator/features/gpa_calculator/presentation/homa_tab/percentage_converter_screen.dart';

/// Pixel match: header with title/subtitle + bell/avatar, solid-blue
/// "Welcome back" banner with illustration, white "Detailed Results" row,
/// dashed "FEATURES" divider, 4 lavender feature cards, bottom nav.
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppDimensions.spaceL),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Dashboard', style: AppTextStyles.h1),
                    Text('Track your academic performance', style: AppTextStyles.caption),
                  ],
                ),
                Row(
                  children: [
                    Stack(
                      children: [
                        const Icon(Icons.notifications_none, size: AppDimensions.iconL, color: AppColors.textPrimary),
                        Positioned(
                          right: 0, top: 0,
                          child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle)),
                        ),
                      ],
                    ),
                    const SizedBox(width: AppDimensions.spaceS),
                    const CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.primary,
                      child: Icon(Icons.person, color: Colors.white, size: 18),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.spaceL),
            _welcomeBanner(),
            const SizedBox(height: AppDimensions.spaceM),
            _detailedResultsRow(),
            const SizedBox(height: AppDimensions.spaceL),
            _featuresDivider(),
            const SizedBox(height: AppDimensions.spaceM),
            FeatureCard(
              icon: Icons.calculate_outlined,
              accentColor: AppColors.gpaBlue,
              title: 'GPA Calculator',
              subtitle: 'Semester GPA',
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const GpaCalculatorScreen()),
                );
              },
            ),
            const SizedBox(height: AppDimensions.spaceS),
            FeatureCard(
              icon: Icons.school_outlined,
              accentColor: AppColors.cgpaPurple,
              title: 'CGPA Calculator',
              subtitle: 'Cumulative GPA',
              // ⬇️ wired: navigates to the new CgpaCalculatorScreen
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const CgpaCalculatorScreen()),
                );
              },
            ),
            const SizedBox(height: AppDimensions.spaceS),
            FeatureCard(
              icon: Icons.trending_up,
              accentColor: AppColors.plannerGreen,
              title: 'GPA Planner',
              subtitle: 'Plan Target GPA',
              // ⬇️ wired: navigates to the new GpaPlannerConfigScreen
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const GpaPlannerConfigScreen()),
                );
              },
            ),
            const SizedBox(height: AppDimensions.spaceS),
            FeatureCard(
              icon: Icons.percent,
              accentColor: AppColors.percentageOrange,
              title: 'Percentage to GPA',
              subtitle: 'Convert % and GPA',
              // ⬇️ wired: navigates to the new PercentageConverterScreen
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const PercentageConverterScreen()),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(currentIndex: _navIndex, onTap: (i) => setState(() => _navIndex = i)),
    );
  }

  Widget _welcomeBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.spaceL),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppDimensions.radiusCard),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Welcome back', style: TextStyle(color: Colors.white70, fontSize: 14)),
                const Text('Student!', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                const Text("Let's achieve your\nacademic goals.", style: TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ),
          Container(
            width: 64,
            height: 76,
            decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(10)),
            child: const Image(fit: BoxFit.contain, image: AssetImage('assets/images/dashboard.png')),
          ),
        ],
      ),
    );
  }

  Widget _detailedResultsRow() {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(AppDimensions.radiusCard),
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.spaceM),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppDimensions.radiusCard),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: Row(
          children: [
            Container(
              width: 44, height: 44,
              decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(AppDimensions.radiusIcon)),
              child: const Image(fit: BoxFit.contain, image: AssetImage('assets/images/Group.png')),
            ),
            const SizedBox(width: AppDimensions.spaceM),
             Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Detailed Results', style: AppTextStyles.h2),
                  Text('View your GPA, credit hours, grade points, and performance insights.',
                      style: AppTextStyles.caption, maxLines: 2, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.primary),
          ],
        ),
      ),
    );
  }

  Widget _featuresDivider() {
    return Row(
      children: [
        Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle)),
        const SizedBox(width: AppDimensions.spaceXS),
        Text('FEATURES', style: AppTextStyles.captionSmall),
        const SizedBox(width: AppDimensions.spaceXS),
        Expanded(child: Container(height: 1, color: AppColors.primary.withOpacity(0.3))),
        const SizedBox(width: AppDimensions.spaceXS),
        Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle)),
      ],
    );
  }
}