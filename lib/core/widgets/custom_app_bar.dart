import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_text_styles.dart';

/// Reusable app bar matching Figma: title + subtitle stacked, optional
/// back arrow (inner screens) or trailing settings icon (Dashboard only).
///
/// Examples:
/// - Dashboard: showBackButton=false, trailing=settings gear icon
/// - CGPA Calculator: title="CGPA Calculator", subtitle="Cumulative GPA"
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final bool showBackButton;
  final Widget? trailing;

  const CustomAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.showBackButton = true,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: showBackButton ? 0 : AppDimensions.screenPadding,
      leading: showBackButton
          ? IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, size: 18),
        onPressed: () => Navigator.of(context).maybePop(),
      )
          : null,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: AppTextStyles.screenTitle),
          if (subtitle != null) ...[
            const SizedBox(height: 2),
            Text(subtitle!, style: AppTextStyles.screenSubtitle),
          ],
        ],
      ),
      actions: trailing != null
          ? [
        Padding(
          padding: const EdgeInsets.only(right: AppDimensions.spaceLg),
          child: trailing,
        ),
      ]
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
    subtitle != null
        ? AppDimensions.appBarHeight + 18
        : AppDimensions.appBarHeight,
  );
}

/// Convenience settings gear button used on the Dashboard app bar.
class SettingsIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  const SettingsIconButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.settings_outlined, color: AppColors.textPrimary),
      onPressed: onPressed,
    );
  }
}