import 'package:flutter/material.dart';
import 'package:gpa_calculator/core/common_widgets/custom_button.dart';
import 'package:gpa_calculator/core/common_widgets/custom_card.dart';
import 'package:gpa_calculator/core/constants/app_dimensions.dart';
import 'package:gpa_calculator/core/theme/app_colors.dart';
import 'package:gpa_calculator/core/theme/app_text_styles.dart';
import 'package:gpa_calculator/features/gpa_calculator/data/models/semester_entry_model.dart';
import 'package:gpa_calculator/features/gpa_calculator/presentation/widgets/smester_entry_card.dart';

import 'cgpa_result_screen.dart';

/// Full "CGPA Calculator" screen — single scrolling page matching Figma
/// exactly: Configuration (Use Credit Hours toggle + GPA Scale chips),
/// Number of Semesters quick-select, dynamic semester list, GPA Calculate.
class CgpaCalculatorScreen extends StatefulWidget {
  const CgpaCalculatorScreen({super.key});

  @override
  State<CgpaCalculatorScreen> createState() => _CgpaCalculatorScreenState();
}

class _CgpaCalculatorScreenState extends State<CgpaCalculatorScreen> {
  bool _useCreditHours = false;
  double _gpaScale = 4.0;
  int _semesterCount = 6;
  List<SemesterEntry> _semesters = List.generate(6, (i) => SemesterEntry(label: 'Semester ${i + 1}'));
  bool _isCalculating = false;

  static const _quickCounts = [3, 5, 6, 8, 10];
  static const _scales = [4.0, 5.0, 10.0];

  bool get _canCalculate => _semesters.every((s) => s.isValid(_useCreditHours));

  void _setSemesterCount(int n) {
    setState(() {
      _semesterCount = n;
      _semesters = List.generate(
        n,
            (i) => i < _semesters.length ? _semesters[i] : SemesterEntry(label: 'Semester ${i + 1}'),
      );
    });
  }

  void _deleteSemester(int index) {
    if (_semesters.length <= 1) return;
    setState(() {
      _semesters.removeAt(index);
      _semesterCount = _semesters.length;
    });
  }

  double _calculateCgpa() {
    if (_useCreditHours) {
      double totalPoints = 0;
      double totalCredits = 0;
      for (final s in _semesters) {
        totalPoints += (s.gpa ?? 0) * (s.credits ?? 0);
        totalCredits += s.credits ?? 0;
      }
      return totalCredits == 0 ? 0 : totalPoints / totalCredits;
    } else {
      final gpas = _semesters.map((s) => s.gpa ?? 0).toList();
      if (gpas.isEmpty) return 0;
      return gpas.reduce((a, b) => a + b) / gpas.length;
    }
  }

  Future<void> _calculate() async {
    setState(() => _isCalculating = true);
    await Future.delayed(const Duration(milliseconds: 400)); // placeholder for repository/save call
    if (!mounted) return;
    setState(() => _isCalculating = false);

    final totalCredits = _semesters.fold<double>(0, (sum, s) => sum + (s.credits ?? 0));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CgpaResultScreen(
          cgpa: _calculateCgpa(),
          totalCreditHours: totalCredits,
          semesterCount: _semesters.length,
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
            Text('CGPA Calculator', style: AppTextStyles.h2),
            Text('Cumulative GPA', style: AppTextStyles.caption),
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
                     Text('Use Credit Hours', style: AppTextStyles.body),
                    Switch(
                      value: _useCreditHours,
                      activeColor: AppColors.primary,
                      onChanged: (v) => setState(() => _useCreditHours = v),
                    ),
                  ],
                ),
                 Text('Weight semesters by credit hours', style: AppTextStyles.caption),
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

          // ---- Number of Semesters ----
          CustomCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text('Number of Semesters', style: AppTextStyles.sectionTitle),
                    Container(
                      width: 34, height: 34,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: AppColors.chipInactiveBg, borderRadius: BorderRadius.circular(AppDimensions.radiusChip)),
                      child: Text('$_semesterCount', style: AppTextStyles.bodyBold.copyWith(color: AppColors.primary)),
                    ),
                  ],
                ),
                 Text('Quick Select:', style: AppTextStyles.caption),
                const SizedBox(height: AppDimensions.spaceM),
                Wrap(
                  spacing: AppDimensions.spaceS,
                  runSpacing: AppDimensions.spaceS,
                  children: _quickCounts.map((n) {
                    return CustomChip(label: '$n', selected: _semesterCount == n, onTap: () => _setSemesterCount(n));
                  }).toList(),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppDimensions.spaceS),

          // ---- Semester list ----
          ...List.generate(_semesters.length, (i) {
            return SemesterEntryCard(
              entry: _semesters[i],
              useCreditHours: _useCreditHours,
              onChanged: () => setState(() {}),
              onDelete: _semesters.length > 1 ? () => _deleteSemester(i) : null,
            );
          }),

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