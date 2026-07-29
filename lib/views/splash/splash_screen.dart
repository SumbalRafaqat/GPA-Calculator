import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/onboarding_provider.dart';
import '../onboarding/permission_screen.dart';
import '../dashboard/dashboard_screen.dart';

/// App entry screen: shows the logo with a real animated loading
/// progress bar (0% → 100%), then routes to onboarding (first launch)
/// or straight to the Dashboard (returning users).
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _progress;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _progress = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _navigateNext();
      }
    });
  }

  Future<void> _navigateNext() async {
    final onboardingProvider = context.read<OnboardingProvider>();
    onboardingProvider.loadOnboardingStatus();

    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => onboardingProvider.isOnboardingComplete
            ? const DashboardScreen()
            : const PermissionScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40),
            AnimatedBuilder(
              animation: _progress,
              builder: (context, _) {
                return SizedBox(
                  width: 160,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: _progress.value,
                      minHeight: 6,
                      backgroundColor: Colors.white24,
                      valueColor: const AlwaysStoppedAnimation(Colors.white),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}