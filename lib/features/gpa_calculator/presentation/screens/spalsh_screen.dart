import 'package:flutter/material.dart';
import 'package:gpa_calculator/core/theme/app_colors.dart';
import 'package:gpa_calculator/features/gpa_calculator/presentation/screens/language_screen.dart';

/// Pixel match: gradient blue-to-purple background, white rounded-square
/// logo mark, title + tagline, 3-dot onboarding progress indicator
/// (dot 2 of 3 active).
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>

               const LanguageScreen(),
        ),
      );
    });
  }

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
            colors: [AppColors.gradientTop, AppColors.gradientBottom],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 4),
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(Icons.school, color: AppColors.gradientTop, size: 48),
              ),
              const SizedBox(height: 24),
              const Text(
                'GPA Planner',
                style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 6),
              const Text(
                'TRACK. CALCULATE. EXCEL.',
                style: TextStyle(color: Colors.white70, fontSize: 12, letterSpacing: 1.4, fontWeight: FontWeight.w600),
              ),
              const Spacer(flex: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _dot(active: false),
                  const SizedBox(width: 6),
                  _dot(active: true, wide: true),
                  const SizedBox(width: 6),
                  _dot(active: false),
                ],
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dot({required bool active, bool wide = false}) {
    return Container(
      width: wide ? 40 : 24,
      height: 4,
      decoration: BoxDecoration(
        color: active ? const Color(0xFF1E6FF2) : Colors.white70,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}