import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/utils/gpa_calculator_util.dart';
import '../../core/utils/validators.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';
import '../../l10n/app_localizations.dart';

class GpaToPercentageScreen extends StatefulWidget {
  const GpaToPercentageScreen({super.key});

  @override
  State<GpaToPercentageScreen> createState() => _GpaToPercentageScreenState();
}

class _GpaToPercentageScreenState extends State<GpaToPercentageScreen> {
  final TextEditingController _gpaController = TextEditingController();
  final TextEditingController _percentageController = TextEditingController();
  String? _errorText;

  @override
  void dispose() {
    _gpaController.dispose();
    _percentageController.dispose();
    super.dispose();
  }

  void _calculate() {
    final error = Validators.validateGpa(_gpaController.text);
    if (error != null) {
      setState(() => _errorText = error);
      return;
    }

    final gpa = double.parse(_gpaController.text);
    final percentage = GpaCalculatorUtil.gpaToPercentage(gpa);

    setState(() {
      _errorText = null;
      _percentageController.text = percentage.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.gpaToPercentageTitle,
        subtitle: l10n.gpaToPercentageSubtitle,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              label: l10n.gpaLabel,
              hintText: 'e.g. 3.42',
              isNumeric: true,
              controller: _gpaController,
              errorText: _errorText,
            ),
            const SizedBox(height: AppDimensions.spaceLg),
            Center(
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_downward,
                  color: Colors.white,
                  size: AppDimensions.iconMd,
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.spaceLg),
            CustomTextField(
              label: l10n.percentageLabel,
              hintText: l10n.resultPlaceholder,
              controller: _percentageController,
              enabled: false,
              suffixText: const Text('%'),
            ),
            const Spacer(),
            CustomButton(
              label: l10n.percentageCalculateButton,
              icon: Icons.calculate_outlined,
              onPressed: _calculate,
            ),
          ],
        ),
      ),
    );
  }
}