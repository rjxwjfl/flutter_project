// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:intl/intl.dart';

// Task Model
class TaskModel {
  int? taskId;
  int prjId;
  int authorId;
  int? managerId;
  String title;
  String? taskDesc;
  DateTime createAt;
  DateTime updateAt;
  DateTime? completeAt;
  DateTime startOn;
  DateTime expireOn;
  int taskState;

  TaskModel(
      {this.taskId,
      required this.prjId,
      required this.authorId,
      this.managerId,
      required this.title,
      this.taskDesc,
      required this.createAt,
      required this.updateAt,
      this.completeAt,
      required this.startOn,
      required this.expireOn,
      required this.taskState});

  Map<String, dynamic> toMap() {
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return <String, dynamic>{
      'task_id': taskId,
      'prj_id': prjId,
      'author_id': authorId,
      'manager_id': managerId,
      'title': title,
      'task_desc': taskDesc,
      'create_at': formatter.format(createAt),
      'update_at': formatter.format(updateAt),
      'complete_at': formatter.format(completeAt!),
      'start_on': formatter.format(startOn),
      'expire_on': formatter.format(expireOn),
      'task_state': taskState
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
        taskId: map['task_id'] != null ? map['task_id'] as int : null,
        prjId: map['prj_id'] as int,
        authorId: map['author_id'] as int,
        managerId: map['manager_id'] != null ? map['manager_id'] as int : null,
        title: map['title'] as String,
        taskDesc: map['task_desc'] != null ? map['task_desc'] as String : null,
        createAt: DateTime.parse(map['create_at']),
        updateAt: DateTime.parse(map['update_at']),
        completeAt: map['complete_at'] != null ? DateTime.parse(map['complete_at']) : null,
        startOn: DateTime.parse(map['start_on']),
        expireOn: DateTime.parse(map['expire_on']),
        taskState: map['task_state'] as int);
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) => TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
