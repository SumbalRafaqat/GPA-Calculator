import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../core/services/share_service.dart';
import '../../providers/settings_provider.dart';
import '../../providers/locale_provider.dart';
import '../../l10n/app_localizations.dart';
import '../onboarding/language_screen.dart';

/// Settings screen — Notification, Reset Templates, Clear Statistics,
/// Choose Language, Share, Rate us, Feedback, Privacy Policy.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final ShareService _shareService = ShareService();

  // TODO: replace with your real Play Store listing and privacy policy URL
  // once the app is published.
  static const String _playStoreUrl =
      'https://play.google.com/store/apps/details?id=com.example.gpa_calculator';
  static const String _privacyPolicyUrl =
      'https://example.com/gpa-planner/privacy-policy';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SettingsProvider>().loadSettings();
    });
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open link')),
      );
    }
  }

  Future<void> _shareApp() async {
    await _shareService.shareText(
      'Check out GPA Planner — track, calculate, and excel! $_playStoreUrl',
    );
  }

  Future<void> _showFeedbackDialog(AppLocalizations l10n) async {
    final controller = TextEditingController();

    await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.feedback),
        content: TextField(
          controller: controller,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: l10n.feedbackHint,
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(l10n.cancelButton),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.feedbackThanksMessage)),
                );
              }
            },
            child: Text(l10n.submitButton),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmClearStatistics(
      SettingsProvider provider,
      AppLocalizations l10n,
      ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.clearStatistics),
        content: Text(l10n.clearStatisticsSubtitle),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.cancelButton),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(
              l10n.clearStatistics,
              style: const TextStyle(color: AppColors.deleteRed),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await provider.clearStatistics();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.statisticsClearedMessage)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<SettingsProvider>();
    final localeProvider = context.watch<LocaleProvider>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustomAppBar(title: l10n.settingsTitle),
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.screenPadding),
        children: [
          _SettingsGroup(
            children: [
              _SettingsTile(
                icon: Icons.notifications_none,
                title: l10n.notification,
                subtitle: l10n.notificationSubtitle,
                trailing: Switch(
                  value: settingsProvider.notificationsEnabled,
                  activeColor: AppColors.primary,
                  onChanged: settingsProvider.toggleNotifications,
                ),
              ),
              _SettingsTile(
                icon: Icons.refresh,
                title: l10n.resetTemplates,
                subtitle: l10n.resetTemplatesSubtitle,
                onTap: () async {
                  await settingsProvider.resetTemplates();
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.templatesResetMessage)),
                    );
                  }
                },
              ),
              _SettingsTile(
                icon: Icons.bar_chart_outlined,
                title: l10n.clearStatistics,
                subtitle: l10n.clearStatisticsSubtitle,
                onTap: () => _confirmClearStatistics(settingsProvider, l10n),
                isLast: true,
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceLg),
          _SettingsGroup(
            children: [
              _SettingsTile(
                icon: Icons.language_outlined,
                title: l10n.chooseLanguage,
                subtitle: localeProvider.currentLanguage.displayName,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const LanguageScreen()),
                  );
                },
              ),
              _SettingsTile(
                icon: Icons.share_outlined,
                title: l10n.shareApp,
                subtitle: l10n.shareAppSubtitle,
                onTap: _shareApp,
                isLast: true,
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceLg),
          _SettingsGroup(
            children: [
              _SettingsTile(
                icon: Icons.star_border,
                title: l10n.rateUs,
                subtitle: l10n.rateUsSubtitle,
                onTap: () => _openUrl(_playStoreUrl),
              ),
              _SettingsTile(
                icon: Icons.chat_bubble_outline,
                title: l10n.feedback,
                subtitle: l10n.feedbackSubtitle,
                onTap: () => _showFeedbackDialog(l10n),
              ),
              _SettingsTile(
                icon: Icons.lock_outline,
                title: l10n.privacyPolicy,
                subtitle: l10n.privacyPolicySubtitle,
                onTap: () => _openUrl(_privacyPolicyUrl),
                isLast: true,
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceXl),
          const Center(
            child: Text('Version 1.0.0', style: AppTextStyles.statLabel),
          ),
        ],
      ),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  final List<Widget> children;
  const _SettingsGroup({required this.children});

  @override
  Widget build(BuildContext context) => Card(child: Column(children: children));
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool isLast;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.trailing,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.spaceLg),
            child: Row(
              children: [
                Icon(icon, color: AppColors.primary, size: AppDimensions.iconMd),
                const SizedBox(width: AppDimensions.spaceMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: AppTextStyles.listItemTitle),
                      const SizedBox(height: 2),
                      Text(subtitle, style: AppTextStyles.listItemSubtitle),
                    ],
                  ),
                ),
                trailing ??
                    (onTap != null
                        ? const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textSecondary)
                        : const SizedBox.shrink()),
              ],
            ),
          ),
        ),
        if (!isLast) const Divider(height: 1, color: AppColors.border),
      ],
    );
  }
}