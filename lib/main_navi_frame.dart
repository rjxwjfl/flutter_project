import 'package:flutter/material.dart';
import 'package:flutter_dowith/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainNaviFrame extends StatefulWidget {
  const MainNaviFrame({Key? key}) : super(key: key);

  @override
  State<MainNaviFrame> createState() => _MainNaviFrameState();
}

class _MainNaviFrameState extends State<MainNaviFrame> {

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
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
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            var refs = ref.watch(pageRoute);
            return Scaffold(
              body: PageView(
                controller: refs.pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: refs.routes,
              ),
              bottomNavigationBar: SizedBox(
                child: BottomNavigationBar(
                  selectedItemColor: scheme.primary,
                  unselectedItemColor: scheme.secondary,
                  // showSelectedLabels: false,
                  // showUnselectedLabels: false,
                  selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
                  unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
                  selectedFontSize: 12,
                  unselectedFontSize: 10,
                  unselectedIconTheme: const IconThemeData(size: 20),
                  currentIndex: refs.selectedIndex,
                  type: BottomNavigationBarType.fixed,
                  onTap: (index) {
                    refs.pageRouteNavigator(index);
                  },
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.house), label: "홈"),
                    BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.calendarCheck), label: "ToDo"),
                    BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.users), label: "Do With"),
                    BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.commentDots), label: "쪽지함"),
                    BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.gears), label: "설정"),
                  ],
                ),
              ),
              resizeToAvoidBottomInset: true,
            );
          },
        ),
      ),
    );
  }
}
