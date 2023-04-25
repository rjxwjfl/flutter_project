import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/task/task_model.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({super.key});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  List<TaskModel> sampleModel = [];

  TaskModel sampleOne = TaskModel(
    taskId: 1,
    prjId: 4,
    authorId: 8,
    title: "First task sample",
    taskDesc: "Task sample for App build\n"
        "task manager will come soon.",
    createAt: DateTime.now(),
    updateAt: DateTime.now(),
    startOn: DateTime.now().add(const Duration(days: 5)),
    expireOn: DateTime.now().add(const Duration(days: 15)),
    taskState: 0,
  );

  TaskModel sampleTwo = TaskModel(
    taskId: 2,
    prjId: 4,
    authorId: 8,
    title: "Second task sample",
    taskDesc: "Task sample for App build\n"
        "task manager will come soon.",
    createAt: DateTime.now(),
    updateAt: DateTime.now(),
    startOn: DateTime.now().add(const Duration(days: 5)),
    expireOn: DateTime.now().add(const Duration(days: 15)),
    taskState: 0,
  );

  @override
  void initState() {
    super.initState();
    sampleModel.add(sampleOne);
    sampleModel.add(sampleTwo);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView.builder(shrinkWrap: true, itemCount: sampleModel.length, itemBuilder: (context, index) {}),
    );
  }
}
