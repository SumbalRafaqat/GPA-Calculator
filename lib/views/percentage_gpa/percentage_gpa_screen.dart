import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/utils/gpa_calculator_util.dart';
import '../../core/utils/validators.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';
import '../../l10n/app_localizations.dart';

class PercentageGpaScreen extends StatefulWidget {
  const PercentageGpaScreen({super.key});

  @override
  State<PercentageGpaScreen> createState() => _PercentageGpaScreenState();
}

class _PercentageGpaScreenState extends State<PercentageGpaScreen> {
  final TextEditingController _percentageController = TextEditingController();
  final TextEditingController _gpaController = TextEditingController();
  String? _errorText;

  @override
  void dispose() {
    _percentageController.dispose();
    _gpaController.dispose();
    super.dispose();
  }

  void _calculate() {
    final error = Validators.validatePercentage(_percentageController.text);
    if (error != null) {
      setState(() => _errorText = error);
      return;
    }

    final percentage = double.parse(_percentageController.text);
    final gpa = GpaCalculatorUtil.percentageToGpa(percentage);

    setState(() {
      _errorText = null;
      _gpaController.text = gpa.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.percentageToGpaTitle,
        subtitle: l10n.percentageToGpaSubtitle,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              label: l10n.percentageLabel,
              hintText: '85.50',
              isNumeric: true,
              controller: _percentageController,
              errorText: _errorText,
              suffixText: const Text('%'),
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
              label: l10n.gpaLabel,
              hintText: l10n.resultPlaceholder,
              controller: _gpaController,
              enabled: false,
            ),
            const Spacer(),
            CustomButton(
              label: l10n.gpaCalculateButton,
              icon: Icons.calculate_outlined,
              onPressed: _calculate,
            ),
          ],
        ),
      ),
    );
  }
}