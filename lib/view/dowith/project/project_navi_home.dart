import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/project/project_model.dart';
import 'package:flutter_dowith/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProjectNaviHome extends ConsumerWidget {
  const ProjectNaviHome({ Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    var refs = ref.watch(prjRoute);
    return Scaffold(
      body: PageView(
        controller: refs.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: refs.routes,
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
        currentIndex: refs.selectedIndex,
        onTap: (index){
          refs.projectRouteNavigator(index);
        },
      ),
    );
  }
}