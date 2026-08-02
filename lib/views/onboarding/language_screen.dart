import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_text_styles.dart';
import '../../models/language_model.dart';
import '../../providers/locale_provider.dart';
import '../../providers/onboarding_provider.dart';
import '../../l10n/app_localizations.dart';
import '../dashboard/dashboard_screen.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  late String _selectedCode;

  @override
  void initState() {
    super.initState();
    _selectedCode = context.read<LocaleProvider>().locale.languageCode;
  }

  Future<void> _confirmSelection() async {
    final localeProvider = context.read<LocaleProvider>();
    final onboardingProvider = context.read<OnboardingProvider>();

    await localeProvider.setLocale(_selectedCode);
    await onboardingProvider.completeOnboarding();

    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const DashboardScreen()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // no back button
        title: Text(l10n.languagesTitle, style: AppTextStyles.screenTitle),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppDimensions.spaceLg),
            child: IconButton(
              icon: const Icon(
                Icons.check_circle,
                color: AppColors.primary
              ),
              onPressed: _confirmSelection,
            ),
          ),
        ],      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.screenPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppDimensions.spaceSm),
            Text(
              l10n.selectLanguageSubtitle,
              style: AppTextStyles.screenSubtitle,
            ),
            const SizedBox(height: AppDimensions.spaceLg),
            Expanded(
              child: ListView.separated(
                itemCount: LanguageModel.supportedLanguages.length,
                separatorBuilder: (_, __) =>
                const SizedBox(height: AppDimensions.spaceMd),
                itemBuilder: (context, index) {
                  final language = LanguageModel.supportedLanguages[index];
                  final isSelected = language.code == _selectedCode;

                  return _LanguageTile(
                    language: language,
                    isSelected: isSelected,
                    onTap: () => setState(() => _selectedCode = language.code),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  final LanguageModel language;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageTile({
    required this.language,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spaceLg,
          vertical: AppDimensions.spaceLg,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              language.displayName,
              style: isSelected
                  ? AppTextStyles.cardTitle.copyWith(color: Colors.white)
                  : AppTextStyles.cardTitle,
            ),
            Radio<String>(
              value: language.code,
              groupValue: isSelected ? language.code : null,
              onChanged: (_) => onTap(),
              activeColor: Colors.white,
              fillColor: isSelected
                  ? const WidgetStatePropertyAll(Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}