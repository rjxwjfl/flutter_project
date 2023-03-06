import 'package:flutter/material.dart';
import 'theme_palette.dart';

class ThemeProvider extends ChangeNotifier {
  late ColorScheme _colorScheme;
  final bool _isDarkMode = false;

  ThemeProvider() {
    _colorScheme = themeSwitcher(_isDarkMode, 0);
  }

  get isDarkMode => _isDarkMode;

  get colorScheme => _colorScheme;

  themeSwitcher(bool isDarMode, int value) {
    if (!isDarMode) {
      switch (value) {
        case 1:
          return lightPaleScheme;
        case 2:
          return lightPurpleTheme;
        case 3:
          return lightPinkScheme;
        case 4:
          return lightAmberScheme;
        case 5:
          return lightWoodScheme;
        default:
          return lightPaleScheme;
      }
    } else {
      switch (value) {
        case 1:
          return darkPaleScheme;
        case 2:
          return darkPurpleTheme;
        case 3:
          return darkPinkScheme;
        case 4:
          return darkAmberScheme;
        case 5:
          return darkWoodScheme;
        default:
          return darkPaleScheme;
      }
    }
  }

  void themeSelector(bool isDarkMode, int mode) {
    _colorScheme = themeSwitcher(isDarkMode, mode);
    notifyListeners();
  }

  modeSwitcher(bool isDarkMode) {
    switch (isDarkMode) {
      case false:
        return 1;
      case true:
        return 2;
      default:
        return 1;
    }
  }
}
