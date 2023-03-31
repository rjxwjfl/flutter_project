import 'package:flutter/material.dart';
import 'package:flutter_dowith/view/dowith/project/project_inbox.dart';
import 'package:flutter_dowith/view/dowith/project/project_overview.dart';

class ProjectHome extends StatefulWidget {
  const ProjectHome({Key? key}) : super(key: key);

  @override
  State<ProjectHome> createState() => _ProjectHomeState();
}

class _ProjectHomeState extends State<ProjectHome> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    ProjectOverView(),
    Text('ENTIRE'),
    Text('ENTRUSTED'),
    ProjectInbox()
  ];

  void _onTap(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 12.0,
        unselectedFontSize: 12.0,
        selectedItemColor: scheme.primary,
        unselectedItemColor: scheme.secondary,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'OVERVIEW',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'ENTIRE',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'ENTRUSTED',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'INBOX',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onTap,
      ),
    );
  }
}
