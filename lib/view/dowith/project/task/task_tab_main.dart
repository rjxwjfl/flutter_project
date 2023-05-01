import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/database_bloc/taskCtrl/task_bloc.dart';
import 'package:flutter_dowith/bloc/database_bloc/taskCtrl/task_repository.dart';
import 'package:flutter_dowith/main.dart';
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

  final List<Widget> _tabs = [
    const Tab(text: "전체"),
    const Tab(text: "참여중"),
  ];
  late List<Widget> _views;

  Future<void> blocInit() async{
    int? userId = prefs.getInt('user_id');
    await _taskBloc.getTask(widget.prjId);
    await _taskBloc.getUserTask(userId!, widget.prjId);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    blocInit();
    _views = [
      TaskListView(stream: _taskBloc.getTaskOriCtrl),
      TaskListView(stream: _taskBloc.getMyTaskListCtrl),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("업무 확인"),
        bottom: TabBar(controller: _tabController, tabs: _tabs),
      ),
      body: TabBarView(controller: _tabController, children: _views),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(FontAwesomeIcons.plus),
      ),
    );
  }
}
