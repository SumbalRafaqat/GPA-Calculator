import 'package:flutter/material.dart';
import 'package:gpa_calculator/core/common_widgets/custom_button.dart';
import 'package:gpa_calculator/core/constants/app_dimensions.dart';
import 'package:gpa_calculator/core/theme/app_colors.dart';
import 'package:gpa_calculator/core/theme/app_text_styles.dart';
import 'package:gpa_calculator/features/gpa_calculator/presentation/homa_tab/coversion_result_screen.dart';


class PercentageConverterScreen extends StatefulWidget {
  const PercentageConverterScreen({super.key});

  @override
  State<PercentageConverterScreen> createState() => _PercentageConverterScreenState();
}

class _PercentageConverterScreenState extends State<PercentageConverterScreen> {
  bool _percentToGpaMode = true; // true: top=Percentage, bottom=GPA
  double _gpaScale = 4.0;

  final _topCtrl = TextEditingController(text: '85.50');
  final _bottomCtrl = TextEditingController();

  bool _isCalculating = false;

  @override
  void initState() {
    super.initState();
    _recompute();
  }

  @override
  void dispose() {
    _topCtrl.dispose();
    _bottomCtrl.dispose();
    super.dispose();
  }

  void _recompute() {
    final input = double.tryParse(_topCtrl.text) ?? 0;
    final output = _percentToGpaMode ? (input / 100) * _gpaScale : (input / _gpaScale) * 100;
    _bottomCtrl.text = output.toStringAsFixed(2);
  }

  void _swapDirection() {
    setState(() {
      _percentToGpaMode = !_percentToGpaMode;
      final swapped = _bottomCtrl.text;
      _topCtrl.text = swapped;
      _recompute();
    });
  }

  Future<void> _calculate() async {
    setState(() => _isCalculating = true);
    await Future.delayed(const Duration(milliseconds: 300)); // placeholder for repository/save call
    if (!mounted) return;
    setState(() => _isCalculating = false);

    final input = double.tryParse(_topCtrl.text) ?? 0;
    final output = double.tryParse(_bottomCtrl.text) ?? 0;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ConversionResultScreen(
          fromLabel: _percentToGpaMode ? 'Percentage' : 'GPA',
          fromValue: input,
          fromIsPercent: _percentToGpaMode,
          toLabel: _percentToGpaMode ? 'GPA' : 'Percentage',
          toValue: output,
          toIsPercent: !_percentToGpaMode,
          gpaScale: _gpaScale,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final topLabel = _percentToGpaMode ? 'Percentage' : 'GPA';
    final bottomLabel = _percentToGpaMode ? 'GPA' : 'Percentage';

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
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.spaceL),
        children: [
          Text(topLabel, style: AppTextStyles.body),
          const SizedBox(height: AppDimensions.spaceS),
          _valueField(
            controller: _topCtrl,
            suffixText: _percentToGpaMode ? '%' : null,
            onChanged: (_) => setState(_recompute),
          ),
          const SizedBox(height: AppDimensions.spaceM),
          Center(
            child: InkWell(
              onTap: _swapDirection,
              borderRadius: BorderRadius.circular(24),
              child: Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                child: const Icon(Icons.swap_vert, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.spaceM),
          Text(bottomLabel, style: AppTextStyles.body),
          const SizedBox(height: AppDimensions.spaceS),
          _valueField(
            controller: _bottomCtrl,
            suffixText: !_percentToGpaMode ? '%' : null,
            enabled: false, // computed field, matches Figma's read-only lower field
          ),
          const SizedBox(height: AppDimensions.spaceXXL),
          CustomButton(
            label: 'GPA Calculate',
            icon: Icons.calculate,
            isPill: true,
            isLoading: _isCalculating,
            onPressed: _calculate,
          ),
        ],
      ),
    );
  }

  Widget _valueField({
    required TextEditingController controller,
    String? suffixText,
    bool enabled = true,
    ValueChanged<String>? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      style: AppTextStyles.fieldInput,
      onChanged: onChanged,
      decoration: InputDecoration(
        suffixText: suffixText,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: AppDimensions.spaceM, vertical: AppDimensions.spaceM),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusField), borderSide: const BorderSide(color: AppColors.cardBorder)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusField), borderSide: const BorderSide(color: AppColors.cardBorder)),
        disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusField), borderSide: const BorderSide(color: AppColors.cardBorder)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusField), borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
      ),
    );
  }
}