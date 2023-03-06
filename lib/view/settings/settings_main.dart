import 'package:flutter/material.dart';

class SettingsMain extends StatelessWidget {
  const SettingsMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Center(
        child: Column(
          children: [],
        ),
      ),
    );
  }
  Widget getMenuTabUI(String title){
    return Column(
      children: [

      ],
    );
  }
  Widget itemCard(){
    return GestureDetector(
      onTap: (){},
      child: Container(
        height: 60,
      ),
    );
  }
}
