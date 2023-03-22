import 'package:flutter/material.dart';
import 'package:flutter_dowith/view/dowith/dowith_main.dart';
import 'package:flutter_dowith/view/outline/todo_outline.dart';
import 'package:flutter_dowith/view/settings/settings_main.dart';
import 'package:flutter_dowith/view/todo/todo_main.dart';

class PageRouteProvider extends ChangeNotifier {
  late int _selectedIndex = 0;
  late PageController _pageController;
  final List<Widget> routes = [
    const TodoOutline(),
    const TodoMain(),
    const DoWithMain(),
    const SettingsMain(),
  ];

  PageRouteProvider() {
    print("PageRouteProvider initialized");
    _pageController = PageController(initialPage: _selectedIndex);
  }

  get pageController => _pageController;
  get selectedIndex => _selectedIndex;

  void pageRouteNavigator(index) {
    _selectedIndex = index;
    print("select= $index, provider= $_selectedIndex");
    _pageController.jumpToPage(_selectedIndex);
    notifyListeners();
  }

  void keepPage(){
    _pageController.jumpToPage(_selectedIndex);
    notifyListeners();
  }
}
