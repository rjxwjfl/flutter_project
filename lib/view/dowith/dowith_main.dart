import 'package:flutter/material.dart';
import 'package:flutter_dowith/view/dowith/project_tabview.dart';
import 'package:flutter_dowith/view/dowith/search_tabview.dart';

class DoWithMain extends StatefulWidget {
  const DoWithMain({super.key});

  @override
  State<DoWithMain> createState() => _DoWithMainState();
}

class _DoWithMainState extends State<DoWithMain> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController;
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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

  List<Widget> tabList = [const Tab(text: "SEARCH"), const Tab(text: "MY PROJECT")];

  @override
  Widget build(BuildContext context) {
    ColorScheme _schme = Theme.of(context).colorScheme;
    super.build(context);
    return Material(
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: () {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: Scaffold(
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
              SearchTabView(textEditingController: _textEditingController, focusNode: _focusNode, materialColor: setMaterialColor()),
              ProjectTabView()
            ],
          ),
        ),
      ),
    );
  }
  @override
  bool get wantKeepAlive => true;
}
