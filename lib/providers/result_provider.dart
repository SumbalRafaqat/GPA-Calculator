import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:open_file/open_file.dart';
import '../core/services/export_service.dart';
import '../core/services/image_export_service.dart';
import '../core/services/share_service.dart';

/// ViewModel driving the Result screen's PDF / Image / Share / Download
/// actions. Each action has its own loading flag so tapping one button
/// doesn't spin all four.
class ResultProvider extends ChangeNotifier {
  final ExportService _exportService = ExportService();
  final ImageExportService _imageExportService = ImageExportService();
  final ShareService _shareService = ShareService();

  String _title = '';
  String _headlineValue = '';
  Map<String, String> _stats = {};

  bool _isPdfLoading = false;
  bool _isImageLoading = false;
  bool _isShareLoading = false;
  bool _isDownloadLoading = false;
  String? _errorMessage;
  Uint8List? _previewImageBytes;

  String get title => _title;
  String get headlineValue => _headlineValue;
  Map<String, String> get stats => Map.unmodifiable(_stats);
  bool get isPdfLoading => _isPdfLoading;
  bool get isImageLoading => _isImageLoading;
  bool get isShareLoading => _isShareLoading;
  bool get isDownloadLoading => _isDownloadLoading;
  String? get errorMessage => _errorMessage;
  Uint8List? get previewImageBytes => _previewImageBytes;

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

  /// Generates the PDF and opens it with the device's default PDF viewer.
  Future<void> openPdf() async {
    _isPdfLoading = true;
    notifyListeners();
    try {
      final file = await _exportService.generateResultPdf(
        title: _title,
        headlineLabel: 'Your GPA',
        headlineValue: _headlineValue,
        stats: _stats,
      );
      await OpenFile.open(file.path);
    } catch (e) {
      _errorMessage = 'Failed to open PDF: $e';
    } finally {
      _isPdfLoading = false;
      notifyListeners();
    }
  }

  /// Generates the result image and stores its bytes so the UI can
  /// display it in an in-app preview (no download, no share here).
  Future<void> generateImagePreview(GlobalKey repaintBoundaryKey) async {
    _isImageLoading = true;
    notifyListeners();
    try {
      final bytes =
      await _imageExportService.captureWidgetAsPng(repaintBoundaryKey);
      _previewImageBytes = bytes;
    } catch (e) {
      _errorMessage = 'Failed to generate image: $e';
    } finally {
      _isImageLoading = false;
      notifyListeners();
    }
  }

  void clearImagePreview() {
    _previewImageBytes = null;
    notifyListeners();
  }

  /// Shares the PDF report via the OS share sheet.
  Future<void> shareResult() async {
    _isShareLoading = true;
    notifyListeners();
    try {
      final file = await _exportService.generateResultPdf(
        title: _title,
        headlineLabel: 'Your GPA',
        headlineValue: _headlineValue,
        stats: _stats,
      );
      await _shareService.shareFile(file, text: 'My $_title: $_headlineValue');
    } catch (e) {
      _errorMessage = 'Failed to share: $e';
    } finally {
      _isShareLoading = false;
      notifyListeners();
    }
  }

  /// Generates the result image and saves it to the device (Download).
  Future<File?> downloadImage(GlobalKey repaintBoundaryKey) async {
    _isDownloadLoading = true;
    notifyListeners();
    try {
      final bytes =
      await _imageExportService.captureWidgetAsPng(repaintBoundaryKey);
      final file = await _imageExportService.saveBytesAsImageFile(
        bytes,
        fileName: 'gpa_result_${DateTime.now().millisecondsSinceEpoch}',
      );
      return file;
    } catch (e) {
      _errorMessage = 'Failed to download image: $e';
      return null;
    } finally {
      _isDownloadLoading = false;
      notifyListeners();
    }
  }

  void clear() {
    _title = '';
    _headlineValue = '';
    _stats = {};
    _errorMessage = null;
    _previewImageBytes = null;
    notifyListeners();
  }
}