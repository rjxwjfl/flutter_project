import 'package:flutter/material.dart';
import 'package:flutter_dowith/firebase/auth.dart';
import 'package:flutter_dowith/main.dart';

class ProjectTabView extends StatelessWidget {
  const ProjectTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: (){
              Auth().test();
            }, child: const Text("TEST")),
            ElevatedButton(onPressed: (){
              print(prefs.getInt("user_id"));
            }, child: const Text("TEST 2"))
          ],
        ),
      ),
    );
  }
}
