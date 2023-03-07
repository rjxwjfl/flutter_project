import 'package:flutter/material.dart';
import 'theme_palette.dart';

class ThemeProvider extends ChangeNotifier {
  late ColorScheme _colorScheme;
  bool _isDarkMode = false;
  final int _modeValue = 1;

  ThemeProvider() {
    _colorScheme = themeSwitcher(_isDarkMode, _modeValue);
  }

  bool get isDarkMode => _isDarkMode;

  set isDarkMode(bool value){
    _isDarkMode = value;
    notifyListeners();
  }

  get colorScheme => _colorScheme;

  get modeValue => _modeValue;

  

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

  void themeSelector(int mode) {
    _colorScheme = themeSwitcher(_isDarkMode, mode);
    notifyListeners();
  }

  void modeSelector(bool isDarkMode){
    _colorScheme = themeSwitcher(isDarkMode, _modeValue);
    notifyListeners();
  }


}
