import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/task/task_view_compact_model.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({required this.stream, Key? key}) : super(key: key);

  final Stream<List<TaskViewCompactModel>> stream;

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {

  Future<void> initialize() async{
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: StreamBuilder<List<TaskViewCompactModel>>(
        stream: widget.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData){
            return const Center(child: CircularProgressIndicator(),);
          }
          List<TaskViewCompactModel>data = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Text(data[index].taskSub);
            },
          );
        }
      ),
    );
  }
}
