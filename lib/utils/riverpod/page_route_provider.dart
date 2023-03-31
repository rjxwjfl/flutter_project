import 'package:flutter/material.dart';
import 'package:flutter_dowith/view/dowith/dowith_main.dart';
import 'package:flutter_dowith/view/outline/todo_outline.dart';
import 'package:flutter_dowith/view/settings/settings_main.dart';
import 'package:flutter_dowith/view/todo/todo_main.dart';

class PageRouteProvider extends ChangeNotifier {
  late int _selectedIndex = 0;
  late PageController _pageController;
  late String _title;
  final List<Widget> routes = [
    const TodoOutline(),
    const TodoMain(),
    const DoWithMain(),
    const SettingsMain(),
  ];

  PageRouteProvider() {
    print("PageRouteProvider initialized");
    _pageController = PageController(initialPage: _selectedIndex);
    _title = setTitle(0);
  }

  get pageController => _pageController;
  get selectedIndex => _selectedIndex;
  get title => _title;

  void pageRouteNavigator(index) {
    _selectedIndex = index;
    _title = setTitle(index);
    _pageController.jumpToPage(_selectedIndex);
    notifyListeners();
  }

  void keepPage(){
    _pageController.jumpToPage(_selectedIndex);
    notifyListeners();
  }

  String setTitle(index){
    switch(index){
      case 0:
        return "HOME";
      case 1:
        return "TODO LIST";
      case 2:
        return "DO WITH";
      case 3:
        return "SETTINGS";
      default:
        return "HOME";
    }
  }
}
