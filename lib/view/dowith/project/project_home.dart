import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/project/project_model.dart';
import 'package:flutter_dowith/view/dowith/project/project_entire.dart';
import 'package:flutter_dowith/view/dowith/project/project_inbox.dart';
import 'package:flutter_dowith/view/dowith/project/project_overview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProjectHome extends StatefulWidget {
  const ProjectHome({required this.data, Key? key}) : super(key: key);

  final ProjectModel data;

  @override
  State<ProjectHome> createState() => _ProjectHomeState();
}

class _ProjectHomeState extends State<ProjectHome> with TickerProviderStateMixin {
  late int _selectedIndex;
  late TabController _tabController;

  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
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
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: scheme.primary,
        unselectedItemColor: scheme.secondary,
        unselectedIconTheme: const IconThemeData(size: 18),
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.house), label: '개요'),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.filePen), label: 'ENTIRE'),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.commentDots), label: 'FEED'),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.folderOpen), label: 'INBOX'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onTap,
      ),
    );
  }
}
