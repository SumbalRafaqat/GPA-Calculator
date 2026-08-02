import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../core/widgets/custom_button.dart';
import '../../providers/gpa_calculator_provider.dart';
import '../../l10n/app_localizations.dart';
import '../result/result_screen.dart';
import 'widgets/course_input_card.dart';

/// GPA Calculator screen — matches Figma "Courses (N) / Input Type:
/// manual" with a dynamic, scrollable list of course cards and a
/// bottom "GPA Calculate" action button.
class GpaCalculatorScreen extends StatelessWidget {
  const GpaCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GpaCalculatorProvider(),
      child: const _GpaCalculatorView(),
    );
  }
}

class _GpaCalculatorView extends StatelessWidget {
  const _GpaCalculatorView();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GpaCalculatorProvider>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.coursesCountTitle(provider.courses.length),
        subtitle: l10n.inputTypeManual,
        trailing: IconButton(
          icon: const Icon(Icons.add_circle_outline),
          tooltip: 'Add course',
          onPressed: provider.addCourse,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.screenPadding,
        ),
        child: ListView.builder(
          padding: const EdgeInsets.only(top: AppDimensions.spaceMd),
          itemCount: provider.courses.length,
          itemBuilder: (context, i) {
            final course = provider.courses[i];
            return CourseInputCard(
              index: i + 1,
              course: course,
              onNameChanged: (value) =>
                  provider.updateCourse(course.id, name: value),
              onObtainedChanged: (value) => provider.updateCourse(
                course.id,
                obtainedMarks: double.tryParse(value) ?? 0,
              ),
              onTotalChanged: (value) => provider.updateCourse(
                course.id,
                totalMarks: double.tryParse(value) ?? 0,
              ),
              onCreditHoursChanged: (value) => provider.updateCourse(
                course.id,
                creditHours: double.tryParse(value) ?? 0,
              ),
              onDelete: () => provider.removeCourse(course.id),
            );
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.screenPadding),
          child: CustomButton(
            label: l10n.gpaCalculateButton,
            icon: Icons.calculate_outlined,
            onPressed: () async {
              if (!provider.hasValidData) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter at least one course\'s marks before calculating.'),
                  ),
                );
                return;
              }
              final result = await provider.calculate();
              if (context.mounted) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ResultScreen(
                      screenTitle: l10n.semesterResultTitle,
                      screenSubtitle: l10n.gpaCalculatorSubtitle,
                      result: result,
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}