import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class _Keys {
  static const String settingsThemeMode = 'settings_theme_mode';
}

@lazySingleton
class LocalStorageRepository {
  LocalStorageRepository({required SharedPreferences storage})
      : _storage = storage;

  final SharedPreferences _storage;

  Future<bool> setTheme(ThemeMode themeMode) =>
      _storage.setString(_Keys.settingsThemeMode, themeMode.name);

  ThemeMode getTheme() {
    final theme = _storage.getString(_Keys.settingsThemeMode);

    if (theme == null) return ThemeMode.system;

    return theme == ThemeMode.dark.name ? ThemeMode.dark : ThemeMode.light;
  }
}
