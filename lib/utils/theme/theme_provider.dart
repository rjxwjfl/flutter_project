import 'package:flutter/material.dart';
import 'package:flutter_dowith/main.dart';
import 'theme_palette.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeMode _themeMode = ThemeMode.light;
  late ColorScheme _lightColorScheme;
  late ColorScheme _darkColorScheme;
  bool _isDarkMode = prefs.getBool('isDarkMode') ?? false;
  int _schemeValue = prefs.getInt('schemeValue') ?? 0;

  ThemeProvider() {
    _loadFromPrefs();
    _lightColorScheme = lightSchemeSwitcher(_schemeValue);
    _darkColorScheme = darkSchemeSwitcher(_schemeValue);
    _themeMode = _isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  bool get isDarkMode => _isDarkMode;

  set isDarkMode(bool value) {
    _isDarkMode = value;
    if (_isDarkMode) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
    _saveToPrefs();
    notifyListeners();
  }

  get lightColorScheme => _lightColorScheme;

  get darkColorScheme => _darkColorScheme;

  get themeMode => _themeMode;

  get modeValue => _schemeValue;

  void schemeSelector(int value) {
    _schemeValue = value;
    _lightColorScheme = lightSchemeSwitcher(value);
    _darkColorScheme = darkSchemeSwitcher(value);
    _saveToPrefs();
    notifyListeners();
  }

  lightSchemeSwitcher(int value) {
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
  }

  darkSchemeSwitcher(int value) {
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

  _loadFromPrefs() {
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    print("is DarkMode? : ${prefs.getBool('isDarkMode')}");
    _schemeValue = prefs.getInt('schemeValue') ?? 0;
    print("current Scheme code? : ${prefs.getInt('schemeValue')}");
  }

  _saveToPrefs() {
    prefs.setBool('isDarkMode', _isDarkMode);
    prefs.setInt('schemeValue', _schemeValue);
  }
}
