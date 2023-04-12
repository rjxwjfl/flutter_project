import 'package:flutter/material.dart';
import 'package:flutter_dowith/main.dart';
import 'package:flutter_dowith/view/dowith/dw_main.dart';
import 'package:flutter_dowith/view/dowith/project_tabview.dart';
import 'package:flutter_dowith/view/dowith/search_tabview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DwNaviHome extends StatefulWidget {
  const DwNaviHome({super.key});

  @override
  State<DwNaviHome> createState() => _DwNaviHomeState();
}

class _DwNaviHomeState extends State<DwNaviHome> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController;
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _textEditingController = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Color setMaterialColor() {
    if (Theme.of(context).brightness == Brightness.dark) {
      return Theme.of(context).colorScheme.background.withRed(25).withGreen(25).withBlue(25);
    } else {
      return Theme.of(context).colorScheme.background.withRed(240).withGreen(240).withBlue(240);
    }
  }

  List<Widget> tabList = [const Tab(text: "HOME"), const Tab(text: "MY PROJECT"), const Tab(text: "SEARCH")];

  @override
  Widget build(BuildContext context) {
    ColorScheme _schme = Theme.of(context).colorScheme;
    super.build(context);
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: TabBar(
              indicatorColor: _schme.primary,
              indicatorWeight: 3.0,
              labelColor: _schme.primary,
              unselectedLabelColor: _schme.secondary,
              controller: _tabController,
              tabs: tabList,
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              const DwMain(),
              const ProjectTabView(),
              SearchTabView(textEditingController: _textEditingController, focusNode: _focusNode, materialColor: ref.watch(themeProv).setMaterialColor(context)),
            ],
          ),
        );
      },
    );
  }
  @override
  bool get wantKeepAlive => true;
}
