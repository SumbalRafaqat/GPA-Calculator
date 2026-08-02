import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../core/widgets/custom_button.dart';
import '../../providers/cgpa_calculator_provider.dart';
import '../../l10n/app_localizations.dart';
import '../result/result_screen.dart';
import 'widgets/semester_input_card.dart';

/// CGPA Calculator screen — matches Figma "CGPA Calculator /
/// Cumulative GPA" with a dynamic, scrollable list of semester cards
/// (Semester 1..N, each holding a single GPA value) and a bottom
/// "GPA Calculate" action button.
class CgpaCalculatorScreen extends StatelessWidget {
  const CgpaCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CgpaCalculatorProvider(),
      child: const _CgpaCalculatorView(),
    );
  }
}

class _CgpaCalculatorView extends StatelessWidget {
  const _CgpaCalculatorView();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CgpaCalculatorProvider>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.cgpaCalculatorTitle,
        subtitle: l10n.cgpaCalculatorSubtitle,
        trailing: IconButton(
          icon: const Icon(Icons.add_circle_outline),
          tooltip: 'Add semester',
          onPressed: provider.addSemester,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.screenPadding,
        ),
        child: ListView.builder(
          padding: const EdgeInsets.only(top: AppDimensions.spaceMd),
          itemCount: provider.semesters.length,
          itemBuilder: (context, i) {
            final semester = provider.semesters[i];
            return SemesterInputCard(
              semester: semester,
              onGpaChanged: (value) => provider.updateSemesterGpa(
                semester.id,
                double.tryParse(value),
              ),
              onDelete: () => provider.removeSemester(semester.id),
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
                    content: Text('Please enter at least one semester\'s GPA before calculating.'),
                  ),
                );
                return;
              }
              final cgpa = await provider.calculate();
              if (context.mounted) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ResultScreen(
                      screenTitle: l10n.semesterResultTitle,
                      screenSubtitle: l10n.cgpaCalculatorSubtitle,
                      result: null,
                      simpleGpaOverride: cgpa,
                    ),
                  ),
                );
              }
            },          ),
        ),
      ),
    );
  }
}