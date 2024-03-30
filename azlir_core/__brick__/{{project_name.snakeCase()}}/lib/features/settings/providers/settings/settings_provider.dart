import 'package:flutter/material.dart';
import 'package:{{project_name}}/app/helpers/injection.dart';
import 'package:{{project_name}}/core/repositories/local_storage_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_provider.g.dart';

@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  final _localStorageRepository = getIt<LocalStorageRepository>();

  @override
  ThemeMode build() => _localStorageRepository.getTheme();

  Future<void> setTheme(ThemeMode themeMode) async {
    final success = await _localStorageRepository.setTheme(themeMode);
    if (!success) return;

    state = themeMode;
  }
}
