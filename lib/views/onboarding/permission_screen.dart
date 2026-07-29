import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/widgets/custom_button.dart';
import 'language_screen.dart';

/// First-time permission/intro screen. Matches Figma: purple-blue
/// gradient background, graduation-cap logo, "GPA Planner" title,
/// "TRACK. CALCULATE. EXCEL." tagline, and a bottom step indicator
/// (this is step 2 of a 3-step onboarding flow: Splash → Permission →
/// Language). Tapping Continue moves to the Language screen.
class PermissionScreen extends StatelessWidget {
  const PermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.onboardingGradientStart,
              AppColors.onboardingGradientEnd,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                const Spacer(flex: 3),
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(
                    Icons.school_outlined,
                    size: 48,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'GPA Planner',
                  style: AppTextStyles.onboardingTitle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'TRACK. CALCULATE. EXCEL.',
                  style: AppTextStyles.onboardingTagline,
                  textAlign: TextAlign.center,
                ),
                const Spacer(flex: 4),
                _StepIndicator(currentStep: 1, totalSteps: 3),
                const SizedBox(height: 24),
                CustomButton(
                  label: 'Continue',
                  backgroundColor: Colors.white,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const LanguageScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Three-segment progress bar at the bottom of onboarding screens,
/// with the active segment highlighted (matches Figma's dash-dash-dash
/// indicator where the current step is wider/brighter).
class _StepIndicator extends StatelessWidget {
  final int currentStep; // 0-based index of active segment
  final int totalSteps;

  const _StepIndicator({
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps, (index) {
        final isActive = index == currentStep;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 32 : 16,
          height: 4,
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.white38,
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }
}