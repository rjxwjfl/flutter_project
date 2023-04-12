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
    ColorScheme scheme;

    const map = {1: coralVelvetRedL, 2: carrotOrangeL, 3: canaryL, 4: mossGreenL, 5: indigoL, 6: navyL, 7: deeperVioletL};

    scheme = map[value] ?? indigoL;

    return scheme;
  }

  darkSchemeSwitcher(int value) {
    ColorScheme scheme;

    const map = {1: coralVelvetRedD, 2: carrotOrangeD, 3: canaryD, 4: mossGreenD, 5: indigoD, 6: navyD, 7: deeperVioletD};

    scheme = map[value] ?? indigoD;

    return scheme;
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

  Color setMaterialColor(context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return Theme.of(context).colorScheme.background.withRed(25).withGreen(25).withBlue(25);
    } else {
      return Theme.of(context).colorScheme.background.withRed(240).withGreen(240).withBlue(240);
    }
  }
}
