import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/task/task_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TaskTabMain extends StatefulWidget {
  const TaskTabMain({required this.prjId, Key? key}) : super(key: key);

  final int prjId;

  @override
  State<TaskTabMain> createState() => _TaskTabMainState();
}

class _TaskTabMainState extends State<TaskTabMain> {
  List<TaskModel> sampleTask = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: PageView(),
      floatingActionButton: FloatingActionButton(onPressed: (){}, child: const Icon(FontAwesomeIcons.plus),),
    );
  }
}
