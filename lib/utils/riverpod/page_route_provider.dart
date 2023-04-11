import 'package:flutter/material.dart';
import 'package:flutter_dowith/view/dowith/dw_navi_home.dart';
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
    const DwNaviHome(),
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
    String title;
    const map = {
      0: "홈",
      1: "할 일",
      2: "Do With",
      3: "설정"
    };
    title = map[index] ?? "홈";
    return title;
  }
}
