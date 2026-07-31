import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/result_card.dart';
import '../../models/gpa_result_model.dart';
import '../../providers/result_provider.dart';

/// Result screen — matches Figma "Semester Result" / "CGPA Result":
/// blue hero card ("Your GPA 1.76"), two stat tiles (Credit Hours,
/// Percentage), "Academic Performance" card (Average Marks, Total),
/// then PDF / Image / Share / Download action row.
///
/// Accepts either a full [GpaResultModel] (GPA Calculator flow) or a
/// bare [simpleGpaOverride] double (CGPA Calculator flow, which only
/// produces a single cumulative GPA number).
class ResultScreen extends StatefulWidget {
  final String screenTitle;
  final String screenSubtitle;
  final GpaResultModel? result;
  final double? simpleGpaOverride;

  const ResultScreen({
    super.key,
    required this.screenTitle,
    required this.screenSubtitle,
    this.result,
    this.simpleGpaOverride,
  }) : assert(
  result != null || simpleGpaOverride != null,
  'Either result or simpleGpaOverride must be provided',
  );

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final GlobalKey _repaintKey = GlobalKey();

  double get _gpaValue => widget.result?.gpa ?? widget.simpleGpaOverride ?? 0;
  bool get _hasFullStats => widget.result != null;

  @override
  void initState() {
    super.initState();
    // Populate ResultProvider so PDF export has the same data shown on screen.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<ResultProvider>();
      final stats = <String, String>{
        if (_hasFullStats) 'Credit Hours': '${widget.result!.creditHours}',
        if (_hasFullStats) 'Percentage': '${widget.result!.percentage}%',
        if (_hasFullStats)
          'Average Marks': '${widget.result!.averageMarks}',
        if (_hasFullStats)
          'Total':
          '${widget.result!.totalObtainedMarks}/${widget.result!.totalPossibleMarks}',
      };
      provider.setResult(
        title: widget.screenTitle,
        headlineValue: _gpaValue.toStringAsFixed(2),
        stats: stats,
      );
    });
  }

  Future<void> _handlePdf(ResultProvider provider) async {
    final file = await provider.exportPdf();
    if (!mounted) return;
    _showResultSnack(file != null ? 'PDF saved: ${file.path}' : provider.errorMessage);
  }

  Future<void> _handleImage(ResultProvider provider) async {
    final file = await provider.exportImage(_repaintKey);
    if (!mounted) return;
    _showResultSnack(
      file != null ? 'Image saved: ${file.path}' : provider.errorMessage,
    );
  }

  Future<void> _handleShare(ResultProvider provider) async {
    final file = await provider.exportPdf();
    if (file == null) {
      if (mounted) _showResultSnack(provider.errorMessage);
      return;
    }
    await provider.shareFile(file);
  }

  Future<void> _handleDownload(ResultProvider provider) async {
    // "Download" reuses the PDF export and confirms the save location
    // to the user via a snackbar.
    await _handlePdf(provider);
  }

  void _showResultSnack(String? message) {
    if (message == null) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ResultProvider>();

    return Scaffold(
      appBar: CustomAppBar(
        title: widget.screenTitle,
        subtitle: widget.screenSubtitle,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.screenPadding),
        child: Column(
          children: [
            RepaintBoundary(
              key: _repaintKey,
              child: Column(
                children: [
                  ResultCard(value: _gpaValue.toStringAsFixed(2)),
                  if (_hasFullStats) ...[
                    const SizedBox(height: AppDimensions.spaceLg),
                    Row(
                      children: [
                        Expanded(
                          child: ResultStatTile(
                            icon: Icons.school_outlined,
                            value: '${widget.result!.creditHours}',
                            label: 'Credit Hours',
                          ),
                        ),
                        const SizedBox(width: AppDimensions.spaceMd),
                        Expanded(
                          child: ResultStatTile(
                            icon: Icons.percent_outlined,
                            value: '${widget.result!.percentage}',
                            label: 'Percentage',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.spaceLg),
                    AcademicPerformanceCard(
                      averageMarks: '${widget.result!.averageMarks}',
                      total:
                      '${widget.result!.totalObtainedMarks}/${widget.result!.totalPossibleMarks}',
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: AppDimensions.spaceXl),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    label: 'PDF',
                    icon: Icons.picture_as_pdf_outlined,
                    isLoading: provider.isExporting,
                    onPressed: () => _handlePdf(provider),
                  ),
                ),
                const SizedBox(width: AppDimensions.spaceMd),
                Expanded(
                  child: CustomButton(
                    label: 'Image',
                    icon: Icons.image_outlined,
                    isOutlined: true,
                    isLoading: provider.isExporting,
                    onPressed: () => _handleImage(provider),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.spaceMd),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    label: 'Share',
                    icon: Icons.share_outlined,
                    isOutlined: true,
                    isLoading: provider.isExporting,
                    onPressed: () => _handleShare(provider),
                  ),
                ),
                const SizedBox(width: AppDimensions.spaceMd),
                Expanded(
                  child: CustomButton(
                    label: 'Download',
                    icon: Icons.download_outlined,
                    isLoading: provider.isExporting,
                    onPressed: () => _handleDownload(provider),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}