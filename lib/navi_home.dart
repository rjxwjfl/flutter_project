import 'package:flutter/material.dart';
import 'package:flutter_dowith/view/dowith/dowith_main.dart';
import 'package:flutter_dowith/view/outline/todo_outline.dart';
import 'package:flutter_dowith/view/settings/settings_main.dart';
import 'package:flutter_dowith/view/todo/todo_main.dart';

class NaviHome extends StatefulWidget {
  const NaviHome({Key? key}) : super(key: key);

  @override
  State<NaviHome> createState() => _NaviHomeState();
}

class _NaviHomeState extends State<NaviHome> {
  late List<Widget> _pageList;
  late PageController _pageController;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    _pageList = const [
      TodoOutline(),
      TodoMain(),
      DoWithMain(),
      SettingsMain(),
    ];
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    DateTime onBackKey = DateTime.now();
    return WillPopScope(
      onWillPop: () async {
        final delayedTime = DateTime.now().difference(onBackKey);
        final cantExit = delayedTime >= const Duration(seconds: 2);
        onBackKey = DateTime.now();
        if (cantExit) {
          const snackBar = SnackBar(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 5),
            behavior: SnackBarBehavior.floating,
            content: Text(
              '앱을 종료하시려면 한 번 더 눌러주세요.',
              textAlign: TextAlign.center,
            ),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: _pageList,
        ),
        extendBody: true,
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: scheme.onPrimary,
            labelTextStyle: MaterialStateProperty.all(
              const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5),
            ),
          ),
          child: NavigationBar(
            elevation: 12.0,
            animationDuration: const Duration(milliseconds: 500),
            labelBehavior:
                NavigationDestinationLabelBehavior.onlyShowSelected,
            selectedIndex: _selectedIndex,
            height: 70,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
                _pageController.jumpToPage(index);
              });
            },
            destinations: [
              NavigationDestination(
                  selectedIcon:
                  Icon(Icons.assessment_rounded, color: scheme.primary),
                  icon: const Icon(Icons.assessment_outlined),
                  label: 'OUTLINE'),
              NavigationDestination(
                  selectedIcon:
                      Icon(Icons.task_sharp, color: scheme.primary),
                  icon: const Icon(Icons.task_outlined),
                  label: 'TODO'),
              NavigationDestination(
                  selectedIcon: Icon(Icons.supervisor_account_outlined,
                      color: scheme.primary),
                  icon: const Icon(Icons.supervisor_account_rounded),
                  label: 'DO WITH'),
              NavigationDestination(
                  selectedIcon: Icon(Icons.settings_applications,
                      color: scheme.primary),
                  icon: const Icon(Icons.settings_applications_outlined),
                  label: 'SETTINGS'),
            ],
          ),
        ),
      ),
    );
  }
}
