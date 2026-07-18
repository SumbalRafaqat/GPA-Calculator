import 'package:flutter/material.dart';
import 'package:gpa_calculator/core/constants/app_dimensions.dart';
import 'package:gpa_calculator/core/theme/app_colors.dart';
import 'package:gpa_calculator/core/theme/app_text_styles.dart';
import 'package:gpa_calculator/features/dashboard/dashboard_screen.dart';

/// Pixel match: full-width pill rows, selected = solid primary blue with
/// white text + filled radio, unselected = light-grey pill with outline
/// radio, small ad banner pinned at the bottom.
class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selected = 'English';

  static const _languages = ['English', 'العربية', 'فارسی', 'Deutsch', 'Espanol', 'Indonesi'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text('Languages', style: AppTextStyles.h1),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppDimensions.spaceL),
            child: Center(
              child: Container(
                width: 44,
                height: 32,
                decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(AppDimensions.radiusPill)),
                child: InkWell(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(
                        builder: (_) =>

                        const DashboardScreen(),
                      ),);
                    },
                    child: const Icon(Icons.check, color: Colors.white, size: 18)),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spaceL),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Select a language. Change it anytime in settings.', style: AppTextStyles.caption),
            ),
          ),
          const SizedBox(height: AppDimensions.spaceM),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spaceL),
              itemCount: _languages.length,
              separatorBuilder: (_, __) => const SizedBox(height: AppDimensions.spaceS),
              itemBuilder: (context, i) {
                final lang = _languages[i];
                final selected = lang == _selected;
                return InkWell(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
                  onTap: () => setState(() => _selected = lang),
                  child: Container(
                    height: 56,
                    padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spaceL),
                    decoration: BoxDecoration(
                      color: selected ? AppColors.primary : AppColors.chipInactiveBg,
                      borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          lang,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: selected ? Colors.white : AppColors.textPrimary,
                          ),
                        ),
                        Icon(
                          selected ? Icons.radio_button_checked : Icons.radio_button_off,
                          color: selected ? Colors.white : AppColors.textSecondary,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          _adBanner(),
        ],
      ),
    );
  }

  Widget _adBanner() {
    return Container(
      margin: const EdgeInsets.all(AppDimensions.spaceM),
      padding: const EdgeInsets.all(AppDimensions.spaceS),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF8F0),
        borderRadius: BorderRadius.circular(AppDimensions.radiusButton),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(width: 64, height: 64, color: Colors.grey.shade300),
          ),
          const SizedBox(width: AppDimensions.spaceS),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: AppColors.success, borderRadius: BorderRadius.circular(4)),
                  child: const Text('AD', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w700)),
                ),
                const SizedBox(height: 4),
                 Text('Sponsored content preview text goes here…', style: AppTextStyles.captionSmall, maxLines: 2),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.success, borderRadius: BorderRadius.circular(AppDimensions.radiusPill)),
                  child: const Text('Learn More', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}