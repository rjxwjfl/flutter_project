import 'package:flutter/material.dart';
import 'package:flutter_dowith/view/dowith/model/list_overview.dart';

class DoWithMain extends StatelessWidget {
  const DoWithMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          ListOverView()
        ],
      ),
    );
  }
}
