import 'package:flutter/material.dart';
import 'package:flutter_dowith/main.dart';
import 'package:flutter_dowith/view/settings/model/animated_card.dart';
import 'package:flutter_dowith/view/settings/model/item_card.dart';
import 'package:flutter_dowith/view/settings/model/item_switcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsMain extends StatelessWidget {
  const SettingsMain({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("SETTINGS", style: TextStyle(fontSize: 25)), // replaced with RichText widget. ex) S ETTINGS.
      ),
      body: Material(
        color: Theme.of(context).colorScheme.background,
        child: Center(
          child: Column(
            children: [
              getUserProfile(size),
              themeSettingTab(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getUserProfile(Size size){
    return Container(
      height: 210,
      width: size.width * 0.95,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all()
      ),
      child: const Placeholder(),
    );
  }

  Widget themeSettingTab() {
    return SingleChildScrollView(
      child: Consumer(
        builder: (context, ref, child) {
          return Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Column(
              children: [
                SizedBox(
                    height: 60,
                    child: Row(
                      children: const [
                        Text("Theme Settings", style: TextStyle(fontSize: 22, letterSpacing: 1.2),),
                      ],
                    )),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Column(
                    children: [
                      ItemCard(title: "색상 설정", callback: () {}),
                      const AnimatedCard(),
                      ItemSwitcher(
                          title: "다크모드 설정",
                          callback: (value) {
                            ref.watch(themeProv).isDarkMode = value;
                          },
                          value: ref.watch(themeProv).isDarkMode),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
