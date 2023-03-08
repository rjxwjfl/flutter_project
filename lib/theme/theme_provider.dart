import 'package:flutter/material.dart';
import 'theme_palette.dart';

class ThemeProvider extends ChangeNotifier {
  late ColorScheme _colorScheme;
  bool _isDarkMode = false;
  int _modeValue = 0;

  ThemeProvider() {
    _colorScheme = themeSwitcher(_isDarkMode, _modeValue);
  }

  bool get isDarkMode => _isDarkMode;

  set isDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  get colorScheme => _colorScheme;

  get modeValue => _modeValue;

  themeSwitcher(bool isDarMode, int value) {
    if (!isDarMode) {
      switch (value) {
        case 1:
          return coralVelvetRedL;
        case 2:
          return carrotOrangeL;
        case 3:
          return canaryL;
        case 4:
          return mossGreenL;
        case 5:
          return indigoL;
        case 6:
          return navyL;
        case 7:
          return deeperVioletL;
        default:
          return indigoL;
      }
    } else {
      switch (value) {
        case 1:
          return coralVelvetRedD;
        case 2:
          return carrotOrangeD;
        case 3:
          return canaryD;
        case 4:
          return mossGreenD;
        case 5:
          return indigoD;
        case 6:
          return navyD;
        case 7:
          return deeperVioletD;
        default:
          return indigoD;
      }
    }
  }

  void themeSelector(int mode) {
    _modeValue = mode;
    _colorScheme = themeSwitcher(_isDarkMode, mode);
    notifyListeners();
  }

  void modeSelector(bool isDarkMode) {
    _colorScheme = themeSwitcher(isDarkMode, _modeValue);
    notifyListeners();
  }
}
