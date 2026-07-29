import 'package:flutter/material.dart';
import 'package:gpa_calculator/core/theme/app_colors.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNav({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.tune), label: 'Custom'),
        BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), label: 'Templates'),
        BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Statistics'),
        BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: 'Setting'),
      ],
    );
  }
}