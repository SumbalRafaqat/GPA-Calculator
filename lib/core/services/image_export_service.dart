import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';   // ← ADD THIS

import 'package:path_provider/path_provider.dart';

/// Captures a widget (wrapped in a RepaintBoundary) as a PNG image,
/// matching the Result screen's "Image" export button. Requires no
/// extra package beyond Flutter's built-in rendering + path_provider.
class ImageExportService {
  /// Renders the widget behind [repaintBoundaryKey] to PNG bytes.
  /// The caller's View must wrap the result card in:
  ///   RepaintBoundary(key: repaintBoundaryKey, child: ResultCard(...))
  Future<Uint8List> captureWidgetAsPng(
      GlobalKey repaintBoundaryKey, {
        double pixelRatio = 3.0,
      }) async {
    final boundary = repaintBoundaryKey.currentContext?.findRenderObject()
    as RenderRepaintBoundary?;

    if (boundary == null) {
      throw StateError(
        'RepaintBoundary not found. Ensure the key is attached to a '
            'RepaintBoundary widget that is currently mounted.',
      );
    }

    final ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
    final ByteData? byteData =
    await image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData == null) {
      throw StateError('Failed to convert widget to PNG bytes.');
    }

    return byteData.buffer.asUint8List();
  }

  /// Saves PNG bytes to the app's documents directory and returns the File.
  Future<File> saveBytesAsImageFile(
      Uint8List bytes, {
        required String fileName,
      }) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$fileName.png');
    await file.writeAsBytes(bytes);
    return file;
  }
}