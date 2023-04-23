import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/task_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TaskTabMain extends StatefulWidget {
  const TaskTabMain({required this.prjId, Key? key}) : super(key: key);

  final int prjId;

  @override
  State<TaskTabMain> createState() => _TaskTabMainState();
}

class _TaskTabMainState extends State<TaskTabMain> with TickerProviderStateMixin {
  late TabController _tabController;
  List<TaskModel> sampleTask = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "전체"),
            Tab(text: "할당됨"),
            Tab(
              text: "종료됨",
            )
          ],
        ),
      ),
      body: TabBarView(controller: _tabController, children: const [
        Center(
            child: Text(
          "One",
          style: TextStyle(fontSize: 50),
        )),
        Center(
            child: Text(
          "Two",
          style: TextStyle(fontSize: 50),
        )),
        Center(
            child: Text(
          "Three",
          style: TextStyle(fontSize: 50),
        ))
      ]),
      floatingActionButton: FloatingActionButton(onPressed: (){}, child: const Icon(FontAwesomeIcons.plus),),
    );
  }
}
