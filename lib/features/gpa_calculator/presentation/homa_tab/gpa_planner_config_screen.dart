import 'package:flutter/material.dart';
import 'package:gpa_calculator/core/common_widgets/custom_button.dart';
import 'package:gpa_calculator/core/common_widgets/custom_card.dart';
import 'package:gpa_calculator/core/constants/app_dimensions.dart';
import 'package:gpa_calculator/core/theme/app_colors.dart';
import 'package:gpa_calculator/core/theme/app_text_styles.dart';
import 'package:gpa_calculator/features/gpa_calculator/presentation/widgets/labeled_split_field.dart';
import 'gpa_planner_result_screen.dart';


class GpaPlannerConfigScreen extends StatefulWidget {
  const GpaPlannerConfigScreen({super.key});

  @override
  State<GpaPlannerConfigScreen> createState() => _GpaPlannerConfigScreenState();
}

class _GpaPlannerConfigScreenState extends State<GpaPlannerConfigScreen> {
  bool _advancedPlanning = false;
  double _gpaScale = 4.0;

  double? _currentGpa;
  double? _earnedCredits;
  double? _targetGpa;
  double? _plannedCredits;
  int? _remainingSemesters;

  bool _isCalculating = false;

  final _currentGpaCtrl = TextEditingController();
  final _earnedCreditsCtrl = TextEditingController();
  final _targetGpaCtrl = TextEditingController();
  final _plannedCreditsCtrl = TextEditingController();
  final _remainingSemestersCtrl = TextEditingController();

  static const _scales = [4.0, 5.0, 10.0];

  bool get _canCalculate =>
      _currentGpa != null && _earnedCredits != null && _targetGpa != null && _plannedCredits != null;

  @override
  void dispose() {
    _currentGpaCtrl.dispose();
    _earnedCreditsCtrl.dispose();
    _targetGpaCtrl.dispose();
    _plannedCreditsCtrl.dispose();
    _remainingSemestersCtrl.dispose();
    super.dispose();
  }

  /// GPA required across the planned credits to hit the target overall GPA.
  /// Returns null when it can't be computed (planned credits missing/zero).
  double? _requiredFutureGpa() {
    final total = (_earnedCredits ?? 0) + (_plannedCredits ?? 0);
    if (_plannedCredits == null || _plannedCredits == 0 || total == 0) return null;
    final requiredPoints = (_targetGpa! * total) - ((_currentGpa ?? 0) * (_earnedCredits ?? 0));
    return requiredPoints / _plannedCredits!;
  }

  Future<void> _calculate() async {
    setState(() => _isCalculating = true);
    await Future.delayed(const Duration(milliseconds: 400)); // placeholder for repository/save call
    if (!mounted) return;
    setState(() => _isCalculating = false);

    final required = _requiredFutureGpa();
    final achievable = required != null && required <= _gpaScale;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GpaPlannerResultScreen(
          currentGpa: _currentGpa ?? 0,
          targetGpa: _targetGpa ?? 0,
          completedCredits: _earnedCredits ?? 0,
          plannedCredits: _plannedCredits ?? 0,
          requiredGpa: required,
          achievable: achievable,
          gpaScale: _gpaScale,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: AppColors.textPrimary),
        title:  Column(
          children: [
            Text('GPA Planner', style: AppTextStyles.h2),
            Text('Plan Target GPA', style: AppTextStyles.caption),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.spaceL),
        children: [
          // ---- Configuration ----
          CustomCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text('Configuration', style: AppTextStyles.sectionTitle),
                const SizedBox(height: AppDimensions.spaceS),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text('Advanced planning', style: AppTextStyles.body),
                    Switch(
                      value: _advancedPlanning,
                      activeColor: AppColors.primary,
                      onChanged: (v) => setState(() => _advancedPlanning = v),
                    ),
                  ],
                ),
                 Text('Multi Semester Breakdown', style: AppTextStyles.caption),
                const SizedBox(height: AppDimensions.spaceM),
                 Text('GPA Scale', style: AppTextStyles.body),
                const SizedBox(height: AppDimensions.spaceS),
                Wrap(
                  spacing: AppDimensions.spaceS,
                  children: _scales.map((s) {
                    final selected = _gpaScale == s;
                    return CustomChip(label: s.toStringAsFixed(1), selected: selected, onTap: () => setState(() => _gpaScale = s));
                  }).toList(),
                ),
              ],
            ),
          ),

          // ---- Current Status ----
          CustomCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Align(alignment: Alignment.center, child: Text('Current Status', style: AppTextStyles.sectionTitle)),
                const SizedBox(height: AppDimensions.spaceM),
                LabeledSplitField(
                  leftController: _currentGpaCtrl,
                  rightController: _earnedCreditsCtrl,
                  leftCaption: 'Current GPA',
                  rightCaption: 'Earned Credits',
                  onLeftChanged: (v) => setState(() => _currentGpa = double.tryParse(v)),
                  onRightChanged: (v) => setState(() => _earnedCredits = double.tryParse(v)),
                ),
              ],
            ),
          ),

          // ---- Target Goals ----
          CustomCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Align(alignment: Alignment.center, child: Text('Target Goals', style: AppTextStyles.sectionTitle)),
                const SizedBox(height: AppDimensions.spaceM),
                LabeledSplitField(
                  leftController: _targetGpaCtrl,
                  rightController: _plannedCreditsCtrl,
                  leftCaption: 'Target GPA',
                  rightCaption: 'Planned Credits',
                  onLeftChanged: (v) => setState(() => _targetGpa = double.tryParse(v)),
                  onRightChanged: (v) => setState(() => _plannedCredits = double.tryParse(v)),
                ),
              ],
            ),
          ),

          // ---- Advanced Planning (conditional) ----
          if (_advancedPlanning)
            CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Advanced Planning', style: AppTextStyles.sectionTitle),
                  const SizedBox(height: AppDimensions.spaceM),
                  TextFormField(
                    controller: _remainingSemestersCtrl,
                    keyboardType: TextInputType.number,
                    style: AppTextStyles.fieldInput,
                    decoration: InputDecoration(
                      labelText: 'Remaining Semesters',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: AppDimensions.spaceM, vertical: AppDimensions.spaceM),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusField), borderSide: const BorderSide(color: AppColors.cardBorder)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusField), borderSide: const BorderSide(color: AppColors.cardBorder)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusField), borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
                    ),
                    onChanged: (v) => _remainingSemesters = int.tryParse(v),
                  ),
                ],
              ),
            ),

          const SizedBox(height: AppDimensions.spaceS),

          // ---- Calculate ----
          CustomButton(
            label: 'GPA Calculate',
            icon: Icons.calculate,
            isPill: true,
            isLoading: _isCalculating,
            onPressed: _canCalculate ? _calculate : null,
          ),
        ],
      ),
    );
  }
}