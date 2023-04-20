import 'package:flutter/material.dart';
import 'package:flutter_dowith/view/dowith/main_screen/auth_switchboard.dart';
import 'package:flutter_dowith/view/home/main_screen.dart';
import 'package:flutter_dowith/view/message_inbox/message_main.dart';
import 'package:flutter_dowith/view/settings/settings_main.dart';
import 'package:flutter_dowith/view/todo/personal_todo_screen.dart';

class MainRouteProvider extends ChangeNotifier {
  late int _selectedIndex = 0;
  late PageController _pageController;
  late String _title;
  final List<Widget> routes = [
    const MainScreen(),
    const PersonalTodoScreen(),
    const AuthSwitchBoard(),
    const MessageMain(),
    const SettingsMain(),
  ];

  MainRouteProvider() {
    _pageController = PageController(initialPage: _selectedIndex);
  }

  get pageController => _pageController;
  get selectedIndex => _selectedIndex;
  get title => _title;

  void pageRouteNavigator(index) {
    _selectedIndex = index;
    _pageController.jumpToPage(_selectedIndex);
    notifyListeners();
  }

  void keepPage(){
    _pageController.jumpToPage(_selectedIndex);
    notifyListeners();
  }
}
