import 'package:flutter/material.dart';
import 'package:flutter_dowith/view/dowith/project/feed/feed_main.dart';
import 'package:flutter_dowith/view/dowith/project/project_inbox.dart';
import 'package:flutter_dowith/view/dowith/project/project_main.dart';
import 'package:flutter_dowith/view/dowith/project/task/task_tab_main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProjectNaviHome extends StatefulWidget {
  const ProjectNaviHome({required this.prjId, Key? key}) : super(key: key);

  final int prjId;

  @override
  State<ProjectNaviHome> createState() => _ProjectNaviHomeState();
}

class _ProjectNaviHomeState extends State<ProjectNaviHome> {
  late final PageController _pageController;
  int initIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ProjectMain(prjId: widget.prjId),
          TaskTabMain(),
          FeedMain(),
          ProjectInbox(),
        ],
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
        currentIndex: initIndex,
        onTap: (index) {
          setState(() {
            initIndex = index;
            _pageController.jumpToPage(initIndex);
          });
        },
      ),
    );
  }
}
