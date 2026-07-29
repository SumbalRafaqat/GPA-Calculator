import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';   // ← ADD THIS (for GlobalKey)

import '../core/services/export_service.dart';
import '../core/services/image_export_service.dart';
import '../core/services/share_service.dart';

/// Generic ViewModel for any "Result" screen (Semester Result or CGPA
/// Result). Holds the display data and drives the PDF / Image / Share /
/// Download actions seen at the bottom of the Result screen.
///
/// NOTE: relies on ExportService, ImageExportService, ShareService —
/// these live in core/services and are provided in the services batch.
class ResultProvider extends ChangeNotifier {
  final ExportService _exportService = ExportService();
  final ImageExportService _imageExportService = ImageExportService();
  final ShareService _shareService = ShareService();

  String _title = '';
  String _headlineValue = '';
  Map<String, String> _stats = {}; // e.g. {'Credit Hours': '18', 'Percentage': '48.8%'}

  bool _isExporting = false;
  String? _errorMessage;

  String get title => _title;
  String get headlineValue => _headlineValue;
  Map<String, String> get stats => Map.unmodifiable(_stats);
  bool get isExporting => _isExporting;
  String? get errorMessage => _errorMessage;

  /// Populates the result screen with computed data. Called right
  /// after GpaCalculatorProvider.calculate() or
  /// CgpaCalculatorProvider.calculate() returns.
  void setResult({
    required String title,
    required String headlineValue,
    required Map<String, String> stats,
  }) {
    _title = title;
    _headlineValue = headlineValue;
    _stats = stats;
    _errorMessage = null;
    notifyListeners();
  }

  /// Generates a PDF report of the current result and returns the
  /// saved file (also usable for Share/Download).
  Future<File?> exportPdf() async {
    _setExporting(true);
    try {
      final file = await _exportService.generateResultPdf(
        title: _title,
        headlineLabel: 'Your GPA',
        headlineValue: _headlineValue,
        stats: _stats,
      );
      return file;
    } catch (e) {
      _errorMessage = 'Failed to generate PDF: $e';
      notifyListeners();
      return null;
    } finally {
      _setExporting(false);
    }
  }

  /// Captures the result card widget (via RepaintBoundary key passed
  /// from the View) as a PNG image file.
  Future<File?> exportImage(GlobalKey repaintBoundaryKey) async {
    _setExporting(true);
    try {
      final Uint8List bytes =
      await _imageExportService.captureWidgetAsPng(repaintBoundaryKey);
      final file = await _imageExportService.saveBytesAsImageFile(
        bytes,
        fileName: 'gpa_result_${DateTime.now().millisecondsSinceEpoch}',
      );
      return file;
    } catch (e) {
      _errorMessage = 'Failed to export image: $e';
      notifyListeners();
      return null;
    } finally {
      _setExporting(false);
    }
  }

  /// Shares a previously generated file via the OS share sheet.
  Future<void> shareFile(File file) async {
    await _shareService.shareFile(file, text: 'My $_title: $_headlineValue');
  }

  void _setExporting(bool value) {
    _isExporting = value;
    notifyListeners();
  }

  void clear() {
    _title = '';
    _headlineValue = '';
    _stats = {};
    _errorMessage = null;
    notifyListeners();
  }
}
