import 'package:flutter/material.dart';
import 'package:gpa_calculator/core/common_widgets/app_botton_nav.dart';
import 'package:gpa_calculator/core/common_widgets/custom_button.dart';
import 'package:gpa_calculator/core/common_widgets/custom_card.dart';
import 'package:gpa_calculator/core/common_widgets/custom_select_field.dart';
import 'package:gpa_calculator/core/constants/app_dimensions.dart';
import 'package:gpa_calculator/core/theme/app_colors.dart';
import 'package:gpa_calculator/core/theme/app_text_styles.dart';


/// Pixel match of the "GPA Calculator" input flow: Input Method card,
/// Scoring Method card, Template Selection card (Department + Semester
/// selects). Matches screens: Input/Scoring toggle + Department dropdown
/// open + Semester dropdown open.
class GpaCalculatorScreen extends StatefulWidget {
  const GpaCalculatorScreen({super.key});

  @override
  State<GpaCalculatorScreen> createState() => _GpaCalculatorScreenState();
}

class _GpaCalculatorScreenState extends State<GpaCalculatorScreen> {
  bool _useTemplate = true;
  bool _useMarks = true;
  String? _department;
  String? _semester;
  int _navIndex = 0;

  static const _departments = ['Computer Science', 'Zoology', 'Botany', 'Urdu', 'English', 'Education'];
  static const _semesters = ['Semester 1', 'Semester 2', 'Semester 3', 'Semester 4', 'Semester 5', 'Semester 6'];

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
            Text('GPA Calculator', style: AppTextStyles.h2),
            Text('Semester GPA', style: AppTextStyles.caption),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.spaceL),
        children: [
          CustomCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text('Input Method', style: AppTextStyles.h2),
                 Text('Choose how you want to input data', style: AppTextStyles.caption),
                const SizedBox(height: AppDimensions.spaceM),
                CustomSegmentedButton(
                  leftLabel: 'Use Template',
                  rightLabel: 'Manual Entry',
                  isLeftSelected: _useTemplate,
                  onChanged: (v) => setState(() => _useTemplate = v),
                ),
              ],
            ),
          ),
          CustomCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text('Scoring Method', style: AppTextStyles.h2),
                 Text('Choose how you want to score', style: AppTextStyles.caption),
                const SizedBox(height: AppDimensions.spaceM),
                CustomSegmentedButton(
                  leftLabel: 'Use Marks',
                  rightLabel: 'Use Grades',
                  isLeftSelected: _useMarks,
                  onChanged: (v) => setState(() => _useMarks = v),
                ),
              ],
            ),
          ),
          if (_useTemplate)
            CustomCard(
              margin: const EdgeInsets.only(bottom: AppDimensions.spaceXXL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text('Template Selection', style: AppTextStyles.h2),
                   Text('Select department and semester', style: AppTextStyles.caption),
                  const SizedBox(height: AppDimensions.spaceM),
                  CustomSelectField<String>(
                    label: 'Department',
                    hint: 'Select your department',
                    value: _department,
                    options: _departments,
                    labelBuilder: (s) => s,
                    onSelected: (v) => setState(() => _department = v),
                  ),
                  const SizedBox(height: AppDimensions.spaceS),
                  CustomSelectField<String>(
                    label: 'Semester',
                    hint: 'Semester',
                    value: _semester,
                    options: _semesters,
                    labelBuilder: (s) => s,
                    onSelected: (v) => setState(() => _semester = v),
                  ),
                ],
              ),
            ),
          CustomButton(
            label: 'Continue',
            isPill: false,
            backgroundColor: AppColors.primary,
            onPressed: (_department != null && _semester != null) || !_useTemplate
                ? () => Navigator.pushNamed(context, '/gpa-course-entry')
                : null,
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNav(currentIndex: _navIndex, onTap: (i) => setState(() => _navIndex = i)),
    );
  }
}