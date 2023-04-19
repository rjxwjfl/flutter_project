import 'package:flutter/material.dart';
import 'package:flutter_dowith/view/dowith/project/calendar/prj_calendar_main.dart';
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
          ProjectCalendarMain(),
          TaskTabMain(),
          FeedMain(),
          ProjectInbox(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: scheme.primary,
        unselectedItemColor: scheme.secondary,
        unselectedIconTheme: const IconThemeData(size: 18),
        selectedFontSize: 12,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.d), label: '개요'),
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.calendarDay), label: '일정표'),
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.filePen), label: '과업'),
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.commentDots), label: '소식'),
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.folderOpen), label: '보관함'),
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
