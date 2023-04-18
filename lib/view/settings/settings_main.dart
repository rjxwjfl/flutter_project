import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dowith/firebase/auth.dart';
import 'package:flutter_dowith/firebase/firestore_stream_controller.dart';
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
    return Center(
        child: Column(
          children: [
            getUserProfile(size),
            themeSettingTab(),
            ElevatedButton(onPressed: (){
              Auth().signOutSession();
            }, child: const Text("SignOut"),),
          ],
        ),
      );
  }

  Widget getUserProfile(Size size) {
    User? user = Auth().auth.currentUser;
    return Container(
      height: 210,
      width: size.width * 0.95,
      decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)), border: Border.all()),
      child: StreamBuilder(
        stream: null,
        builder: (context, snapshot) {
          return Container();
        },
      ),
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
                        Text(
                          "Theme Settings",
                          style: TextStyle(fontSize: 22, letterSpacing: 1.2),
                        ),
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
                            ref.watch(theme).isDarkMode = value;
                          },
                          value: ref.watch(theme).isDarkMode),
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
