import 'dart:io';
import 'package:share_plus/share_plus.dart';

/// Wraps share_plus so the rest of the app never imports it directly.
/// Requires package: share_plus: ^9.0.0 (add to pubspec.yaml).
class ShareService {
  /// Shares a file (PDF or image) via the native OS share sheet,
  /// matching the Result screen's "Share" button.
  Future<void> shareFile(File file, {String? text}) async {
    await Share.shareXFiles(
      [XFile(file.path)],
      text: text,
    );
  }

  /// Shares plain text only (used by Settings → "Share" — invite
  /// friends to use the app).
  Future<void> shareText(String text) async {
    await Share.share(text);
  }
}