import 'package:flutter/material.dart';
import 'package:flutter_dowith/main.dart';
import 'package:flutter_dowith/view/dowith/project/model/search_model.dart';
import 'package:flutter_dowith/view/dowith/project_add_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NaviHome extends StatefulWidget {
  const NaviHome({Key? key}) : super(key: key);

  @override
  State<NaviHome> createState() => _NaviHomeState();
}

class _NaviHomeState extends State<NaviHome> {
  late final TextEditingController _textEditingController = TextEditingController();
  late final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
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
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            var refs = ref.watch(routeProv);
            return Scaffold(
              appBar: AppBar(
                title: Text(refs.title),
                elevation: 0.0,
                backgroundColor: scheme.background,
                foregroundColor: scheme.onBackground,
                actions: refs.selectedIndex == 2
                    ? [
                        IconButton(
                            onPressed: () {
                              callPopUp(context);
                            },
                            icon: const FaIcon(FontAwesomeIcons.magnifyingGlass)),
                        IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const ProjectAddUI()));
                            },
                            icon: const FaIcon(FontAwesomeIcons.calendarPlus)),
                        const SizedBox(width: 5)
                      ]
                    : [],
              ),
              body: PageView(
                controller: refs.pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: refs.routes,
              ),
              bottomNavigationBar: SizedBox(
                height: 55,
                child: BottomNavigationBar(
                  selectedItemColor: scheme.primary,
                  unselectedItemColor: scheme.secondary,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  unselectedIconTheme: const IconThemeData(size: 18),
                  type: BottomNavigationBarType.fixed,
                  currentIndex: refs.selectedIndex,
                  onTap: (index) {
                    refs.pageRouteNavigator(index);
                  },
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.house), label: "Home"),
                    BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.calendarXmark), label: "ToDo"),
                    BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.users), label: "Do With"),
                    BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.gears), label: "Setting"),
                  ],
                ),
              ),
              extendBody: true,
            );
          },
        ),
      ),
    );
  }

  void callPopUp(context) {
    Size size = MediaQuery.of(context).size;
    double verticalPadding = size.width * 0.05;
    double horizontalPadding = size.height * 0.35;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.fromLTRB(verticalPadding, horizontalPadding, verticalPadding, horizontalPadding),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: const BorderRadius.all(Radius.circular(24.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(color: Colors.grey.withOpacity(0.2), offset: const Offset(4, 4), blurRadius: 8.0),
              ],
            ),
            child: Column(
              children: [
                SearchBarUI(controller: _textEditingController, hintText: "SEARCHING FOR", focusNode: _focusNode),
                Divider(height: 2,),
                Expanded(
                  child: SizedBox(
                    child: Text("Bottom"),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
