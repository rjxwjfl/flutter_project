import 'package:flutter/material.dart';
import 'package:flutter_dowith/view/dowith/dw_main.dart';
import 'package:flutter_dowith/view/dowith/project_tabview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DwNaviHome extends StatefulWidget {
  const DwNaviHome({super.key});

  @override
  State<DwNaviHome> createState() => _DwNaviHomeState();
}

class _DwNaviHomeState extends State<DwNaviHome> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
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

  List<Widget> tabList = [const Tab(text: "HOME"), const Tab(text: "MY PROJECT")];

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    super.build(context);
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: TabBar(
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
              DwMain(),
              ProjectTabView(),
            ],
          ),
        );
      },
    );
  }
  @override
  bool get wantKeepAlive => true;
}
