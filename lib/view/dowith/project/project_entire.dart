import 'package:flutter/material.dart';

class ProjectEntire extends StatelessWidget {
  const ProjectEntire({required this.controller, Key? key}) : super(key: key);

  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: controller,
        children: [
          Center( child: Text("One",style: TextStyle(fontSize: 50),)),
          Center( child: Text("Two",style: TextStyle(fontSize: 50),)),
          Center( child: Text("Three",style: TextStyle(fontSize: 50),))
        ]);
  }
}
