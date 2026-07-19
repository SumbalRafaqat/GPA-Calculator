import 'package:flutter/material.dart';
import 'package:gpa_calculator/core/common_widgets/custom_button.dart';
import 'package:gpa_calculator/core/common_widgets/custom_card.dart';
import 'package:gpa_calculator/core/common_widgets/custom_select_field.dart';
import 'package:gpa_calculator/core/constants/app_dimensions.dart';
import 'package:gpa_calculator/core/theme/app_colors.dart';
import 'package:gpa_calculator/core/theme/app_text_styles.dart';
import 'package:gpa_calculator/features/gpa_calculator/data/models/course_model.dart';
import 'package:gpa_calculator/features/gpa_calculator/presentation/homa_tab/semester_result_screen.dart';
import 'package:gpa_calculator/features/gpa_calculator/presentation/widgets/course_card.dart';
import 'package:gpa_calculator/features/gpa_calculator/presentation/widgets/course_header.dart';



class GpaCalculatorScreen extends StatefulWidget {
  const GpaCalculatorScreen({super.key});

  @override
  State<GpaCalculatorScreen> createState() => _GpaCalculatorScreenState();
}

class _GpaCalculatorScreenState extends State<GpaCalculatorScreen> {
  bool _useTemplate = false; // Figma default state for this screen = Manual Entry
  bool _useMarks = true;

  String? _department;
  String? _semester;

  int _courseCount = 6;
  List<CourseEntry> _courses = List.generate(6, (_) => CourseEntry());

  bool _isCalculating = false;

  static const _departments = ['Computer Science', 'Zoology', 'Botany', 'Urdu', 'English', 'Education'];
  static const _semesters = ['Semester 1', 'Semester 2', 'Semester 3', 'Semester 4', 'Semester 5', 'Semester 6'];
  static const _quickCounts = [3, 5, 6, 8, 10];

  bool get _canCalculate {
    if (_useTemplate && (_department == null || _semester == null)) return false;
    return _courses.every((c) => c.isValid);
  }

  void _setCourseCount(int n) {
    setState(() {
      _courseCount = n;
      _courses = List.generate(
        n,
            (i) => i < _courses.length ? _courses[i] : CourseEntry(),
      );
    });
  }

  void _addCourse() {
    setState(() {
      _courses.add(CourseEntry());
      _courseCount = _courses.length;
    });
  }

  void _deleteCourse(int index) {
    if (_courses.length <= 1) return; // keep at least one course
    setState(() {
      _courses.removeAt(index);
      _courseCount = _courses.length;
    });
  }

  double _semesterGpa() {
    double totalPoints = 0;
    double totalCredits = 0;
    for (final c in _courses) {
      final percent = c.percentage ?? 0;
      // simple 4.0-scale mapping — swap for AppColors-driven grade ranges
      // from Custom Grading Settings once that repository is wired in here.
      final gp = (percent / 100) * 4.0;
      totalPoints += gp * c.creditHours;
      totalCredits += c.creditHours;
    }
    return totalCredits == 0 ? 0 : totalPoints / totalCredits;
  }

  Future<void> _calculate() async {
    setState(() => _isCalculating = true);
    await Future.delayed(const Duration(milliseconds: 400)); // placeholder for repository/save call
    if (!mounted) return;
    setState(() => _isCalculating = false);

    final totalObtained = _courses.fold<double>(0, (sum, c) => sum + (c.obtained ?? 0));
    final totalPossible = _courses.fold<double>(0, (sum, c) => sum + c.total);
    final totalCredits = _courses.fold<double>(0, (sum, c) => sum + c.creditHours);
    final avgPercent = totalPossible == 0 ? 0.0 : (totalObtained / totalPossible) * 100;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SemesterResultScreen(
          gpa: _semesterGpa(),
          creditHours: totalCredits,
          percentage: avgPercent,
          totalObtained: totalObtained,
          totalPossible: totalPossible,
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
        title: Column(
          children: [
            Text('GPA Calculator', style: AppTextStyles.h2),
             Text('Semester GPA', style: AppTextStyles.caption),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.spaceL),
        children: [
          // ---- Input Method ----
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

          // ---- Scoring Method ----
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

          // ---- Number of Courses (Manual) OR Template Selection ----
          if (!_useTemplate)
            CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text('Number of Courses', style: AppTextStyles.h2),
                      Container(
                        width: 34, height: 34,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: AppColors.chipInactiveBg, borderRadius: BorderRadius.circular(AppDimensions.radiusChip)),
                        child: Text('$_courseCount', style: AppTextStyles.bodyBold.copyWith(color: AppColors.primary)),
                      ),
                    ],
                  ),
                   Text('Quick Select:', style: AppTextStyles.caption),
                  const SizedBox(height: AppDimensions.spaceM),
                  Wrap(
                    spacing: AppDimensions.spaceS,
                    runSpacing: AppDimensions.spaceS,
                    children: _quickCounts.map((n) {
                      return CustomChip(label: '$n', selected: _courseCount == n, onTap: () => _setCourseCount(n));
                    }).toList(),
                  ),
                ],
              ),
            )
          else
            CustomCard(
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
                  const SizedBox(height: AppDimensions.spaceM),
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

          const SizedBox(height: AppDimensions.spaceXL),

          // ---- Courses header ----
          CoursesHeader(
            count: _courses.length,
            inputType: _useTemplate ? 'template' : 'manual',
            onAdd: _addCourse,
          ),
          const SizedBox(height: AppDimensions.spaceM),

          // ---- Course cards ----
          ...List.generate(_courses.length, (i) {
            return CourseCard(
              index: i,
              course: _courses[i],
              onChanged: () => setState(() {}),
              onDelete: _courses.length > 1 ? () => _deleteCourse(i) : null,
            );
          }),

          const SizedBox(height: AppDimensions.spaceS),

          // ---- Calculate button ----
          CustomButton(
            label: 'GPA Calculate',
            icon: Icons.calculate,
            isPill: true,
            isLoading: _isCalculating,
            onPressed: (){
              Navigator.push(context, 
              MaterialPageRoute(builder: (_)=>SemesterResultScreen(gpa: _semesterGpa(), creditHours: _semesterGpa(), percentage: _semesterGpa(), totalObtained: _semesterGpa(), totalPossible: _semesterGpa(),), )
              );
            }
          ),
        ],
      ),
    );
  }
}