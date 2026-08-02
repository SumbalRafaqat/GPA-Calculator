import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/result_card.dart';
import '../../models/gpa_result_model.dart';
import '../../providers/result_provider.dart';
import '../../l10n/app_localizations.dart';

/// Result screen — matches Figma "Semester Result" / "CGPA Result":
/// blue hero card, stat tiles, Academic Performance card, then
/// PDF / Image / Share / Download action row. Each button behaves
/// independently:
/// - PDF: generates and opens the PDF in the device's PDF viewer.
/// - Image: generates and shows the image in an in-app preview.
/// - Share: shares the PDF via the OS share sheet.
/// - Download: generates the image and saves it to the device.
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final l10n = AppLocalizations.of(context)!;
      final provider = context.read<ResultProvider>();
      final stats = <String, String>{
        if (_hasFullStats) l10n.creditHours: '${widget.result!.creditHours}',
        if (_hasFullStats) l10n.percentageStat: '${widget.result!.percentage}%',
        if (_hasFullStats)
          l10n.averageMarks: '${widget.result!.averageMarks}',
        if (_hasFullStats)
          l10n.totalStat:
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
    await provider.openPdf();
    if (!mounted) return;
    if (provider.errorMessage != null) _showSnack(provider.errorMessage!);
  }

  Future<void> _handleImage(ResultProvider provider) async {
    await provider.generateImagePreview(_repaintKey);
    if (!mounted) return;
    if (provider.errorMessage != null) {
      _showSnack(provider.errorMessage!);
      return;
    }
    if (provider.previewImageBytes != null) {
      await showDialog(
        context: context,
        builder: (dialogContext) => Dialog(
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.spaceLg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.memory(provider.previewImageBytes!),
                const SizedBox(height: AppDimensions.spaceMd),
                CustomButton(
                  label: 'Close',
                  onPressed: () => Navigator.of(dialogContext).pop(),
                ),
              ],
            ),
          ),
        ),
      );
      provider.clearImagePreview();
    }
  }

  Future<void> _handleShare(ResultProvider provider) async {
    await provider.shareResult();
    if (!mounted) return;
    if (provider.errorMessage != null) _showSnack(provider.errorMessage!);
  }

  Future<void> _handleDownload(ResultProvider provider) async {
    final file = await provider.downloadImage(_repaintKey);
    if (!mounted) return;
    _showSnack(
      file != null ? 'Image saved: ${file.path}' : provider.errorMessage,
    );
  }

  void _showSnack(String? message) {
    if (message == null) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ResultProvider>();
    final l10n = AppLocalizations.of(context)!;

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
                  ResultCard(
                    label: l10n.yourGpa,
                    value: _gpaValue.toStringAsFixed(2),
                  ),
                  if (_hasFullStats) ...[
                    const SizedBox(height: AppDimensions.spaceLg),
                    Row(
                      children: [
                        Expanded(
                          child: ResultStatTile(
                            icon: Icons.school_outlined,
                            value: '${widget.result!.creditHours}',
                            label: l10n.creditHours,
                          ),
                        ),
                        const SizedBox(width: AppDimensions.spaceMd),
                        Expanded(
                          child: ResultStatTile(
                            icon: Icons.percent_outlined,
                            value: '${widget.result!.percentage}',
                            label: l10n.percentageStat,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.spaceLg),
                    AcademicPerformanceCard(
                      title: l10n.academicPerformance,
                      averageLabel: l10n.averageMarks,
                      averageMarks: '${widget.result!.averageMarks}',
                      totalLabel: l10n.totalStat,
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
                    label: l10n.pdfButton,
                    icon: Icons.picture_as_pdf_outlined,
                    isOutlined: !provider.isPdfLoading,
                    isLoading: provider.isPdfLoading,
                    onPressed: () => _handlePdf(provider),
                  ),
                ),
                const SizedBox(width: AppDimensions.spaceMd),
                Expanded(
                  child: CustomButton(
                    label: l10n.imageButton,
                    icon: Icons.image_outlined,
                    isOutlined: !provider.isImageLoading,
                    isLoading: provider.isImageLoading,
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
                    label: l10n.shareButton,
                    icon: Icons.share_outlined,
                    isOutlined: !provider.isShareLoading,
                    isLoading: provider.isShareLoading,
                    onPressed: () => _handleShare(provider),
                  ),
                ),
                const SizedBox(width: AppDimensions.spaceMd),
                Expanded(
                  child: CustomButton(
                    label: l10n.downloadButton,
                    icon: Icons.download_outlined,
                    isOutlined: !provider.isDownloadLoading,
                    isLoading: provider.isDownloadLoading,
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