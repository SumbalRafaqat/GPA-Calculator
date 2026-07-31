import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../providers/settings_provider.dart';
import '../../providers/locale_provider.dart';
import '../onboarding/language_screen.dart';

/// Settings screen — matches Figma: Notification toggle, Reset
/// Templates, Clear Statistics grouped in one card; Choose Language +
/// Share in a second card; Rate us / Feedback / Privacy Policy in a
/// third card; app version footer at the bottom.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SettingsProvider>().loadSettings();
    });
  }

  Future<void> _confirmClearStatistics(SettingsProvider provider) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Clear Statistics'),
        content: const Text(
          'This will permanently reset all saved calculations and statistics. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text(
              'Clear',
              style: TextStyle(color: AppColors.deleteRed),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await provider.clearStatistics();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Statistics cleared')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<SettingsProvider>();
    final localeProvider = context.watch<LocaleProvider>();

    return Scaffold(
      appBar: const CustomAppBar(title: 'Settings'),
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.screenPadding),
        children: [
          _SettingsGroup(
            children: [
              _SettingsTile(
                icon: Icons.notifications_none,
                title: 'Notification',
                subtitle:
                'Receive notification updates when messages are deleted.',
                trailing: Switch(
                  value: settingsProvider.notificationsEnabled,
                  activeColor: AppColors.primary,
                  onChanged: settingsProvider.toggleNotifications,
                ),
              ),
              _SettingsTile(
                icon: Icons.refresh,
                title: 'Reset Templates',
                subtitle: 'Restore default course templates',
                onTap: () async {
                  await settingsProvider.resetTemplates();
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Templates reset')),
                    );
                  }
                },
              ),
              _SettingsTile(
                icon: Icons.bar_chart_outlined,
                title: 'Clear Statistics',
                subtitle: 'Reset all saved calculations and statistics',
                onTap: () => _confirmClearStatistics(settingsProvider),
                isLast: true,
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceLg),
          _SettingsGroup(
            children: [
              _SettingsTile(
                icon: Icons.language_outlined,
                title: 'Choose Language',
                subtitle: localeProvider.currentLanguage.displayName,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const LanguageScreen()),
                  );
                },
              ),
              _SettingsTile(
                icon: Icons.share_outlined,
                title: 'Share',
                subtitle: 'Invite friends to use the app',
                onTap: () {
                  // Wired to ShareService.shareText() via ResultProvider's
                  // ShareService dependency if a global share is needed;
                  // kept as a no-op placeholder action here since it needs
                  // no app state, only the OS share sheet.
                },
                isLast: true,
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceLg),
          _SettingsGroup(
            children: [
              _SettingsTile(
                icon: Icons.star_border,
                title: 'Rate us',
                subtitle: 'Give the highest rating',
                onTap: () {},
              ),
              _SettingsTile(
                icon: Icons.chat_bubble_outline,
                title: 'Feedback',
                subtitle: 'Share your experience using our app',
                onTap: () {},
              ),
              _SettingsTile(
                icon: Icons.lock_outline,
                title: 'Privacy Policy',
                subtitle: 'Read our privacy guidelines',
                onTap: () {},
                isLast: true,
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceXl),
          const Center(
            child: Text(
              'Version 1.0.0',
              style: AppTextStyles.statLabel,
            ),
          ),
        ],
      ),
    );
  }
}

/// Rounded card wrapper grouping related settings tiles, matching the
/// Figma settings list sections.
class _SettingsGroup extends StatelessWidget {
  final List<Widget> children;
  const _SettingsGroup({required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: children),
    );
  }
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
                        ? const Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: AppColors.textSecondary,
                    )
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