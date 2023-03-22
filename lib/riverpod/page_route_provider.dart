import 'package:flutter/material.dart';
import 'package:flutter_dowith/view/dowith/dowith_main.dart';
import 'package:flutter_dowith/view/outline/todo_outline.dart';
import 'package:flutter_dowith/view/settings/settings_main.dart';
import 'package:flutter_dowith/view/todo/todo_main.dart';

class PageRouteProvider extends ChangeNotifier{
  late int _selectedIndex = 0;
  late PageController _pageController;
  final List<Widget> routes = [
    const TodoOutline(),
    const TodoMain(),
    const DoWithMain(),
    const SettingsMain(),
  ];

  PageRouteProvider(){
    _pageController = PageController(initialPage: _selectedIndex);
  }

  PageController get pageController => _pageController;

  set pageController(PageController value) {
    _pageController = value;
  }

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int value) {
    _selectedIndex = value;
  }
}