import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/database_bloc/userCtrl/auth.dart';
import 'package:flutter_dowith/main.dart';
import 'package:flutter_dowith/view/settings/model/animated_card.dart';
import 'package:flutter_dowith/view/settings/model/item_card.dart';
import 'package:flutter_dowith/view/settings/model/item_switcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    return Row(
      children: [
        SizedBox(
          child: Row(
            children: [
              buttonUI(false, FontAwesomeIcons.sun, 'LIGHT', context),
              buttonUI(true, FontAwesomeIcons.moon, 'DARK')
            ],
          ),
        )
      ],
    );
  }
  Widget buttonUI(bool isDark, IconData icon, String text, context){
    return Consumer(
      builder: (context, ref, child) {
        var refs = ref.watch(theme);
        return InkWell(
          onTap: (){
            refs.isDarkMode = isDark? false: true;
          },
          child: Ink(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: isDark? Colors.black87 : Colors.white
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: SizedBox(
                width: 100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: isDark? MainAxisAlignment.start : MainAxisAlignment.end,
                    children: isDark? [
                      Text(text, style: const TextStyle(color: Colors.white),),
                      Icon(icon, color: Colors.white,),
                    ] : [
                      Icon(icon, color: Colors.black87,),
                      Text(text, style: const TextStyle(color: Colors.black87),),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
