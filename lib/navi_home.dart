import 'package:flutter/material.dart';
import 'package:flutter_dowith/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NaviHome extends ConsumerWidget {
  const NaviHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    DateTime onBackKey = DateTime.now();
    return WillPopScope(
      onWillPop: () async {
        final delayedTime = DateTime.now().difference(onBackKey);
        final cantExit = delayedTime >= const Duration(seconds: 2);
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
        appBar: AppBar(
          title: Text(ref.watch(routeProv).title),
          elevation: 0.0,
          backgroundColor: scheme.background,
          foregroundColor: scheme.onBackground,
        ),
        body: PageView(
          controller: ref.watch(routeProv).pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: ref.watch(routeProv).routes,
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: scheme.primary,
          unselectedItemColor: scheme.secondary,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedIconTheme: const IconThemeData(size: 20),
          type: BottomNavigationBarType.fixed,
          currentIndex: ref.watch(routeProv).selectedIndex,
          onTap: (index) {
            ref.watch(routeProv).pageRouteNavigator(index);
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.house), label: "Home"),
            BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.calendarXmark), label: "ToDo"),
            BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.users), label: "Do With"),
            BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.gears), label: "Setting"),
          ],
        ),
        extendBody: true,
      ),
    );
  }
}
