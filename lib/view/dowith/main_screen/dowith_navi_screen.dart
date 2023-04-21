import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dowith/main.dart';
import 'package:flutter_dowith/utils/theme/app_theme.dart';
import 'package:flutter_dowith/view/dowith/main_screen/dowith_main_screen.dart';
import 'package:flutter_dowith/view/dowith/main_screen/project_search.dart';
import 'package:flutter_dowith/view/dowith/main_screen/project_tabview.dart';
import 'package:flutter_dowith/view/dowith/project/project_add/project_add_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DoWithTabScreen extends StatefulWidget {
  const DoWithTabScreen({super.key});

  @override
  State<DoWithTabScreen> createState() => _DoWithTabScreenState();
}

class _DoWithTabScreenState extends State<DoWithTabScreen> with TickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Color setMaterialColor() {
    if (Theme.of(context).brightness == Brightness.dark) {
      return Theme.of(context).colorScheme.background.withRed(25).withGreen(25).withBlue(25);
    } else {
      return Theme.of(context).colorScheme.background.withRed(240).withGreen(240).withBlue(240);
    }
  }

  List<Widget> tabList = [const Tab(text: "MY PROJECT"), const Tab(text: "MY PROJECT")];
  List<Widget> tabTitle = [
    const Text(
      "1번 file",
      style: AppTheme.title,
    ),
    const Text("2")
  ];

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Consumer(
      builder: (context, ref, child) {
        return Scaffold(
          appBar: AppBar(
            leading: const SizedBox(),
            leadingWidth: 20.0,
            title: tabTitle[_tabController.index],
            elevation: 0.0,
            backgroundColor: scheme.background,
            foregroundColor: scheme.primary,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => const ProjectSearch()));
                  },
                  icon: const FaIcon(FontAwesomeIcons.magnifyingGlass)),
              IconButton(
                  onPressed: () {
                    ref.watch(drawUp).initialize();
                    showMakePrjUI(context);
                  },
                  icon: const FaIcon(FontAwesomeIcons.calendarPlus)),
              const SizedBox(width: 5)
            ],
            bottom: TabBar(
              indicatorColor: scheme.primary,
              indicatorWeight: 3.0,
              labelColor: scheme.primary,
              unselectedLabelColor: scheme.secondary,
              controller: _tabController,
              tabs: tabList,
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: const [
              DoWithMainScreen(),
              ProjectTabView(),
            ],
          ),
        );
      }
    );
  }

  Future<void> showMakePrjUI(BuildContext context) async{
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10))
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              print("Out of Focus");
            },
            child: const ProjectAddUI()),
      ),
    );
  }
}
