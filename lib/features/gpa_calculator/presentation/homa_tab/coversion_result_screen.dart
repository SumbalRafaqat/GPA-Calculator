import 'package:flutter/material.dart';
import 'package:gpa_calculator/core/common_widgets/custom_button.dart';
import 'package:gpa_calculator/core/constants/app_dimensions.dart';
import 'package:gpa_calculator/core/theme/app_colors.dart';
import 'package:gpa_calculator/core/theme/app_text_styles.dart';

/// Confirmation screen shown after "GPA Calculate" on the Percentage↔GPA
/// converter — blue "from → to" summary card, Scale / Max GPA reference
/// card, "Got it!" to return to the Dashboard.
class ConversionResultScreen extends StatelessWidget {
  final String fromLabel;
  final double fromValue;
  final bool fromIsPercent;
  final String toLabel;
  final double toValue;
  final bool toIsPercent;
  final double gpaScale;

  const ConversionResultScreen({
    super.key,
    required this.fromLabel,
    required this.fromValue,
    required this.fromIsPercent,
    required this.toLabel,
    required this.toValue,
    required this.toIsPercent,
    required this.gpaScale,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: AppColors.textPrimary),
        title: Column(
          children: [
            Text('Percentage to GPA', style: AppTextStyles.h2),
            Text('Convert % and GPA', style: AppTextStyles.caption),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.spaceL),
        child: Column(
          children: [
            _summaryCard(),
            const SizedBox(height: AppDimensions.spaceM),
            _referenceCard(),
            const Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(AppDimensions.spaceL),
        child: CustomButton(
          label: 'Got it!',
          isPill: false,
          backgroundColor: AppColors.primary,
          onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
        ),
      ),
    );
  }

  Widget _summaryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.spaceL, horizontal: AppDimensions.spaceM),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppDimensions.radiusCard),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _valueColumn(fromValue, fromLabel, fromIsPercent),
          const Icon(Icons.arrow_forward, color: Colors.white),
          _valueColumn(toValue, toLabel, toIsPercent),
        ],
      ),
    );
  }

  Widget _valueColumn(double value, String label, bool isPercent) {
    return Column(
      children: [
        Text(
          isPercent ? '${value.toStringAsFixed(1)}%' : value.toStringAsFixed(2),
          style: AppTextStyles.h1.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 2),
        Text(label, style: AppTextStyles.caption.copyWith(color: Colors.white70)),
      ],
    );
  }

  Widget _referenceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusCard),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        children: [
          _referenceRow('Scale', '${gpaScale.toStringAsFixed(1)} Scale'),
          const SizedBox(height: AppDimensions.spaceS),
          _referenceRow('Max GPA', gpaScale.toStringAsFixed(1)),
        ],
      ),
    );
  }

  Widget _referenceRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.body),
        Text(value, style: AppTextStyles.bodyBold),
      ],
    );
  }
}