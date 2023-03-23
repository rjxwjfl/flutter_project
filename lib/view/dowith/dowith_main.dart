import 'package:flutter/material.dart';

class DoWithMain extends StatelessWidget {
  const DoWithMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Do With", style: TextStyle(fontSize: 25)),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('SliverAppBar'),
              background: FlutterLogo(),
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                child: Text("Child"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
