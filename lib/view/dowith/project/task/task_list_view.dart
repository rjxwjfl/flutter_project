import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/task/task_view_compact_model.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({required this.list, Key? key}) : super(key: key);

  final List<TaskViewCompactModel> list;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return taskViewCompact(context, list[index]);
          },
        ),
      ),
    );
  }

  Widget taskViewCompact(context, TaskViewCompactModel model) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 3.0,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            color: Theme.of(context).canvasColor
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ListTile(
                  title: Text(model.taskSub),
                  subtitle: Text(
                    "책임자 : ${model.mgrName}",
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                  trailing: convertPriority(model.priority),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    model.taskDtlDesc,
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                // model.taskPE ? Text("${model.startDate}") : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text convertPriority(int priority) {
    const map = {
      0: Text("낮음", style: TextStyle()),
      1: Text("중간", style: TextStyle()),
      2: Text("높음", style: TextStyle()),
      3: Text(
        "긴급",
        style: TextStyle(color: Colors.redAccent),
      )
    };
    return map[priority]!;
  }
}
