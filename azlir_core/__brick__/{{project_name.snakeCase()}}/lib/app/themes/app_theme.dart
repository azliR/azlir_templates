import 'package:flutter/material.dart';

final class AppTheme {
  static ThemeData _baseTheme(Brightness brightness) => ThemeData(
        brightness: brightness,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );

  static ThemeData generateThemeData({
    required ColorScheme colorScheme,
    required Brightness brightness,
  }) =>
      _baseTheme(brightness).copyWith(
        colorScheme: colorScheme,
        scaffoldBackgroundColor: colorScheme.background,
        menuButtonTheme: MenuButtonThemeData(
          style: MenuItemButton.styleFrom(
            minimumSize: const Size(160, 56),
            padding: const EdgeInsets.fromLTRB(16, 0, 20, 0),
          ),
        ),
        popupMenuTheme: PopupMenuThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
        ),
        dropdownMenuTheme: const DropdownMenuThemeData(
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
          ),
        ),
      );

  static const double defaultRadius = 16;
  static const double defaultNavBarHeight = 80;
  static final double defaultAppBarHeight = AppBar().preferredSize.height;
  static final BorderRadius defaultBoardRadius =
      BorderRadius.circular(defaultRadius);
}
