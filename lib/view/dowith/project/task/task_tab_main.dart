import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/task/task_view_compact_model.dart';
import 'package:flutter_dowith/bloc/database_bloc/taskCtrl/task_bloc.dart';
import 'package:flutter_dowith/bloc/database_bloc/taskCtrl/task_repository.dart';
import 'package:flutter_dowith/main.dart';
import 'package:flutter_dowith/view/dowith/project/task/add_task.dart';
import 'package:flutter_dowith/view/dowith/project/task/task_list_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TaskTabMain extends StatefulWidget {
  const TaskTabMain({required this.prjId, Key? key}) : super(key: key);

  final int prjId;

  @override
  State<TaskTabMain> createState() => _TaskTabMainState();
}

class _TaskTabMainState extends State<TaskTabMain> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final TaskBloc _taskBloc = TaskBloc(TaskRepository());

  Future<void> blocInit() async {
    int? userId = prefs.getInt('user_id');
    await _taskBloc.getTask(widget.prjId);
    await _taskBloc.getUserTask(userId!, widget.prjId);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    blocInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("업무 확인"),
        bottom: TabBar(controller: _tabController, tabs: const [
          Tab(text: "전체"),
          Tab(text: "참여중"),
        ]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          StreamBuilder<List<TaskViewCompactModel>>(
              stream: _taskBloc.getTaskOriCtrl,
              builder: (context, snapshot) {
                return TaskListView(list: _taskBloc.taskList);
              }),
          StreamBuilder<List<TaskViewCompactModel>>(
              stream: _taskBloc.getMyTaskListCtrl,
              builder: (context, snapshot) {
                return TaskListView(list: _taskBloc.userTask);
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, CupertinoPageRoute(builder: (context) => const AddTask())),
        child: const Icon(FontAwesomeIcons.plus),
      ),
    );
  }
}
