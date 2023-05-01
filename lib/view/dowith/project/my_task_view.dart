import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/task/task_assigned_view.dart';
import 'package:flutter_dowith/bloc/database_bloc/taskCtrl/task_bloc.dart';
import 'package:flutter_dowith/bloc/database_bloc/taskCtrl/task_repository.dart';
import 'package:flutter_dowith/view/dowith/project/task/model/task_dtl_view_compact.dart';

class MyTaskView extends StatefulWidget {
  const MyTaskView({required this.userId, this.prjId, Key? key}) : super(key: key);

  final int userId;
  final int? prjId;

  @override
  State<MyTaskView> createState() => _MyTaskViewState();
}

class _MyTaskViewState extends State<MyTaskView> {
  final TaskBloc _taskBloc = TaskBloc(TaskRepository());

  Future<void> blocInit() async{
    if (widget.prjId != null){
      _taskBloc.getPrjCptTask(widget.userId, widget.prjId!);
    } else {
      _taskBloc.getCptTask(widget.userId);
    }
  }

  @override
  void initState() {
    super.initState();
    blocInit();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
      child: StreamBuilder<List<TaskAssignedCompactView>>(
        stream: widget.prjId != null ? _taskBloc.getPrjUserTaskCtrl : _taskBloc.getUserTaskAllCtrl,
        builder: (context, snapshot) {
          if (!snapshot.hasData){
            return const Center(child: CircularProgressIndicator(),);
          }
          List<TaskAssignedCompactView> data = snapshot.data!;
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.isNotEmpty ? 3 : 0,
            itemBuilder: (context, index) {
              return TaskDtlViewCompact(data: data[index],);
            },
          );
        }
      ),
    );
  }
}
