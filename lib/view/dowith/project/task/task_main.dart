import 'package:flutter/material.dart';

class TaskMain extends StatefulWidget {
  const TaskMain({Key? key}) : super(key: key);

  @override
  State<TaskMain> createState() => _TaskMainState();
}

class _TaskMainState extends State<TaskMain> with TickerProviderStateMixin{
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: _tabController,
        children: [
          Center( child: Text("One",style: TextStyle(fontSize: 50),)),
          Center( child: Text("Two",style: TextStyle(fontSize: 50),)),
          Center( child: Text("Three",style: TextStyle(fontSize: 50),))
        ]);
  }
}
