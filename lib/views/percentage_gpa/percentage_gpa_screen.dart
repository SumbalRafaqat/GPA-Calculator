import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';
import '../../providers/percentage_gpa_provider.dart';

/// Percentage ↔ GPA converter screen — matches Figma: Percentage field
/// on top, swap (↔) button in the middle, GPA field below (or reversed
/// direction), plus a "Scale / Max GPA" info sheet triggered from a
/// results view. Fully bidirectional: typing either field live-updates
/// the other via PercentageGpaProvider.
class PercentageGpaScreen extends StatelessWidget {
  const PercentageGpaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PercentageGpaProvider(),
      child: const _PercentageGpaView(),
    );
  }
}

class _PercentageGpaView extends StatelessWidget {
  const _PercentageGpaView();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PercentageGpaProvider>();

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Percentage to GPA',
        subtitle: 'Convert % and GPA',
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              label: 'Percentage',
              hintText: '85.50',
              isNumeric: true,
              initialValue: provider.percentage == 0
                  ? ''
                  : provider.percentage.toString(),
              suffixText: const Text('%', style: AppTextStyles.inputLabel),
              onChanged: provider.updatePercentage,
            ),
            const SizedBox(height: AppDimensions.spaceLg),
            Center(
              child: InkWell(
                onTap: provider.toggleDirection,
                borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.swap_vert,
                    color: Colors.white,
                    size: AppDimensions.iconMd,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.spaceLg),
            CustomTextField(
              label: 'GPA',
              hintText: '3.42',
              isNumeric: true,
              initialValue:
              provider.gpa == 0 ? '' : provider.gpa.toString(),
              onChanged: provider.updateGpa,
            ),
            const Spacer(),
            CustomButton(
              label: 'GPA Calculate',
              icon: Icons.calculate_outlined,
              onPressed: () => _showScaleSheet(context, provider),
            ),
          ],
        ),
      ),
    );
  }

  /// "Scale / Max GPA" bottom sheet — matches Figma's result summary
  /// card ("56.0% → 56.0%", "Scale: 4.0 Scale", "Max GPA: 4.0", "Got it!").
  void _showScaleSheet(
      BuildContext context,
      PercentageGpaProvider provider,
      ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusXl),
        ),
      ),
      builder: (sheetContext) {
        return Padding(
          padding: const EdgeInsets.all(AppDimensions.spaceLg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: AppDimensions.spaceLg,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _ResultChip(
                      value: '${provider.percentage}%',
                      label: 'Percentage',
                    ),
                    const Icon(Icons.arrow_forward, color: Colors.white),
                    _ResultChip(
                      value: '${provider.percentage}%',
                      label: 'Percentage',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppDimensions.spaceLg),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.spaceLg),
                  child: Column(
                    children: [
                      _ScaleRow(label: 'Scale', value: '4.0 Scale'),
                      const SizedBox(height: AppDimensions.spaceSm),
                      _ScaleRow(
                        label: 'Max GPA',
                        value: provider.maxGpa.toStringAsFixed(1),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.spaceLg),
              CustomButton(
                label: 'Got it!',
                onPressed: () => Navigator.of(sheetContext).pop(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ResultChip extends StatelessWidget {
  final String value;
  final String label;
  const _ResultChip({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.resultLabel.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(label, style: AppTextStyles.resultLabel),
      ],
    );
  }
}

class _ScaleRow extends StatelessWidget {
  final String label;
  final String value;
  const _ScaleRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.statLabel),
        Text(value, style: AppTextStyles.statValue),
      ],
    );
  }
}