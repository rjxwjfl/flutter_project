import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/project/project_model.dart';
import 'package:flutter_dowith/view/dowith/project/feed/feed_main.dart';
import 'package:flutter_dowith/view/dowith/project/task/task_main.dart';
import 'package:flutter_dowith/view/dowith/project/project_inbox.dart';
import 'package:flutter_dowith/view/dowith/project/project_main.dart';


class ProjectRouteProvider extends ChangeNotifier {
  late ProjectModel _currentProject;
  late int _selectedIndex = 0;
  late PageController _pageController;
  late String _title;
  final List<Widget> routes = [
    const ProjectMain(),
    const TaskMain(),
    const FeedMain(),
    const ProjectInbox()
  ];

  ProjectRouteProvider() {
    print("PageRouteProvider initialized");
    _pageController = PageController(initialPage: _selectedIndex);
    _title = setTitle(0);
  }

  get pageController => _pageController;
  get selectedIndex => _selectedIndex;
  get title => _title;

  void projectRouteNavigator(index) {
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
