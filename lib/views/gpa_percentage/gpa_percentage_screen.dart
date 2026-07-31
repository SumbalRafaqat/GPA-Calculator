import 'package:flutter/material.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/utils/gpa_calculator_util.dart';
import '../../core/utils/validators.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';

/// GPA → Percentage screen. User types a GPA, taps
/// "Percentage Calculate", and the Percentage field (kept blank/read-only
/// until then) fills in with the converted value.
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
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'GPA to Percentage',
        subtitle: 'Convert GPA and %',
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              label: 'GPA',
              hintText: 'e.g. 3.42',
              isNumeric: true,
              controller: _gpaController,
              errorText: _errorText,
            ),
            const SizedBox(height: AppDimensions.spaceLg),
            CustomTextField(
              label: 'Percentage',
              hintText: 'Result will appear here',
              controller: _percentageController,
              enabled: false,
              suffixText: const Text('%'),
            ),
            const Spacer(),
            CustomButton(
              label: 'Percentage Calculate',
              icon: Icons.calculate_outlined,
              onPressed: _calculate,
            ),
          ],
        ),
      ),
    );
  }
}