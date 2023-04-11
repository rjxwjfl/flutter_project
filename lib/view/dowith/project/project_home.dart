import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/server_bloc/model/project/project_model.dart';
import 'package:flutter_dowith/view/dowith/project/project_entire.dart';
import 'package:flutter_dowith/view/dowith/project/project_inbox.dart';
import 'package:flutter_dowith/view/dowith/project/project_overview.dart';

class ProjectHome extends StatefulWidget {
  const ProjectHome({required this.data, Key? key}) : super(key: key);

  final ProjectModel data;

  @override
  State<ProjectHome> createState() => _ProjectHomeState();
}

class _ProjectHomeState extends State<ProjectHome> with TickerProviderStateMixin {
  late int _selectedIndex;
  late String _title;
  late TabController _tabController;

  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    _title = _setTitle(0);
    _tabController = TabController(length: 3, vsync: this);
    _widgetOptions = <Widget>[
      ProjectOverView(data: widget.data),
      ProjectEntire(
        controller: _tabController,
      ),
      const Text('FEED'),
      const ProjectInbox()
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
      _title = _setTitle(index);
    });
  }

  String _setTitle(index) {
    switch (index) {
      case 0:
        return "OVERVIEW";
      case 1:
        return "ENTIRE";
      case 2:
        return "FEED";
      case 3:
        return "INBOX";
      default:
        return "OVERVIEW";
    }
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        backgroundColor: scheme.background,
        foregroundColor: scheme.onBackground,
        elevation: 0.0,
        bottom: _selectedIndex == 1
            ? TabBar(
                controller: _tabController,
                indicatorColor: scheme.primary,
                labelColor: scheme.onBackground,
                tabs: const [
                  Tab(text: "ALL"),
                  Tab(text: "PARTICIPATED"),
                  Tab(text: "COMPLETED"),
                ],
              )
            : null,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 10.0,
        unselectedFontSize: 10.0,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: scheme.primary,
        unselectedItemColor: scheme.secondary,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'OVERVIEW',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.web_asset_outlined),
            activeIcon: Icon(Icons.web_asset),
            label: 'ENTIRE',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feed_outlined),
            activeIcon: Icon(Icons.feed),
            label: 'FEED',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            activeIcon: Icon(Icons.message),
            label: 'INBOX',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onTap,
      ),
    );
  }
}
