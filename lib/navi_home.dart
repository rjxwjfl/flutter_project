import 'package:flutter/material.dart';
import 'package:flutter_dowith/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NaviHome extends ConsumerWidget {
  const NaviHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    DateTime onBackKey = DateTime.now();
    return WillPopScope(
      onWillPop: () async {
        final delayedTime = DateTime.now().difference(onBackKey);
        final cantExit = delayedTime >= const Duration(seconds: 2);
        onBackKey = DateTime.now();
        if (cantExit) {
          const snackBar = SnackBar(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 5),
            behavior: SnackBarBehavior.floating,
            content: Text(
              '앱을 종료하시려면 한 번 더 눌러주세요.',
              textAlign: TextAlign.center,
            ),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(ref.watch(routeProv).title),
          elevation: 0.0,
          backgroundColor: scheme.background,
          foregroundColor: scheme.onBackground,
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              Container(),
              const Divider(),
              Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.home_outlined),
                    title: const Text("HOME"),
                    onTap: (){
                      ref.watch(routeProv).pageRouteNavigator(0);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.task_outlined),
                    title: const Text("PERSONAL TASK"),
                    onTap: (){
                      ref.watch(routeProv).pageRouteNavigator(1);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.supervisor_account_outlined),
                    title: const Text("DO WITH"),
                    onTap: (){
                      ref.watch(routeProv).pageRouteNavigator(2);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings_outlined),
                    title: const Text("SETTINGS"),
                    onTap: (){
                      ref.watch(routeProv).pageRouteNavigator(3);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        body: PageView(
          controller: ref.watch(routeProv).pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: ref.watch(routeProv).routes,
        ),
        extendBody: true,
      ),
    );
  }
}
