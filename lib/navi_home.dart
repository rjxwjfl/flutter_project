import 'package:flutter/material.dart';
import 'package:flutter_dowith/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NaviHome extends ConsumerWidget {
  const NaviHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          controller: ref.watch(routeProv).pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: ref.watch(routeProv).routes,
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
            animationDuration: const Duration(milliseconds: 500),
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            selectedIndex: ref.watch(routeProv).selectedIndex,
            height: 55,
            onDestinationSelected: (index) {
              ref.watch(routeProv).pageRouteNavigator(index);
            },
            destinations: [
              NavigationDestination(
                  selectedIcon:
                      Icon(Icons.assessment_rounded, color: scheme.primary),
                  icon: const Icon(Icons.assessment_outlined),
                  label: 'OUTLINE'),
              NavigationDestination(
                  selectedIcon: Icon(Icons.task_sharp, color: scheme.primary),
                  icon: const Icon(Icons.task_outlined),
                  label: 'TODO'),
              NavigationDestination(
                  selectedIcon: Icon(Icons.supervisor_account_outlined,
                      color: scheme.primary),
                  icon: const Icon(Icons.supervisor_account_rounded),
                  label: 'DO WITH'),
              NavigationDestination(
                  selectedIcon:
                      Icon(Icons.settings_applications, color: scheme.primary),
                  icon: const Icon(Icons.settings_applications_outlined),
                  label: 'SETTINGS'),
            ],
          ),
        ),
      ),
    );
  }
}
