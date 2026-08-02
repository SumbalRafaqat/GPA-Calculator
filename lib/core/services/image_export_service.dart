import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:gal/gal.dart';

/// Captures a widget (wrapped in a RepaintBoundary) as a PNG image and
/// saves it directly to the device's Gallery/Photos, so the user can
/// find it like any normal photo (visible in Files/Gallery apps).
class ImageExportService {
  /// Renders the widget behind [repaintBoundaryKey] to PNG bytes.
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

  /// Saves PNG bytes to the device's Gallery (visible in Photos/Files
  /// apps immediately). Requests gallery permission automatically.
  Future<void> saveBytesToGallery(
      Uint8List bytes, {
        required String fileName,
      }) async {
    final hasAccess = await Gal.hasAccess();
    if (!hasAccess) {
      final granted = await Gal.requestAccess();
      if (!granted) {
        throw StateError('Gallery permission denied.');
      }
    }

    await Gal.putImageBytes(bytes, name: fileName);
  }
}