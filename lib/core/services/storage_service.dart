import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Wraps SharedPreferences so providers never touch the raw API directly.
/// Keeps persistence logic in one testable place; swapping storage
/// backends later (e.g. to Hive) won't touch provider code.
class StorageService {
  StorageService._internal();
  static final StorageService instance = StorageService._internal();

  SharedPreferences? _prefs;

  /// Must be called once before app start (see main.dart).
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  SharedPreferences get _prefsInstance {
    if (_prefs == null) {
      throw StateError('StorageService.init() must be called before use.');
    }
    return _prefs!;
  }

  // ---- Primitive getters/setters ----

  Future<bool> setString(String key, String value) =>
      _prefsInstance.setString(key, value);

  String? getString(String key) => _prefsInstance.getString(key);

  Future<bool> setBool(String key, bool value) =>
      _prefsInstance.setBool(key, value);

  bool getBool(String key, {bool defaultValue = false}) =>
      _prefsInstance.getBool(key) ?? defaultValue;

  Future<bool> remove(String key) => _prefsInstance.remove(key);

  Future<bool> clearAll() => _prefsInstance.clear();

  // ---- JSON helpers (saved GPA/CGPA result history) ----

  Future<bool> setJson(String key, Map<String, dynamic> value) =>
      setString(key, jsonEncode(value));

  Map<String, dynamic>? getJson(String key) {
    final raw = getString(key);
    if (raw == null) return null;
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  Future<bool> setJsonList(String key, List<Map<String, dynamic>> value) =>
      setString(key, jsonEncode(value));

  List<Map<String, dynamic>> getJsonList(String key) {
    final raw = getString(key);
    if (raw == null) return [];
    final decoded = jsonDecode(raw) as List;
    return decoded.cast<Map<String, dynamic>>();
  }
}