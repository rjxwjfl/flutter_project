import 'package:flutter_dowith/utils/convert_data.dart';

class TaskCreationUserModel {
  int userId;
  int taskUserAttId;
  String taskPnt;
  String? taskCmt;
  int taskState;
  DateTime startDate;
  DateTime endDate;

  TaskCreationUserModel({
    required this.userId,
    required this.taskUserAttId,
    required this.taskPnt,
    this.taskCmt,
    required this.taskState,
    required this.startDate,
    required this.endDate
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'user_id': userId,
      'task_user_att_id': taskUserAttId,
      'task_pnt': taskPnt,
      'task_cmt': taskCmt,
      'task_state': taskState,
      'start_date': dataFormatter.format(startDate),
      'end_date': dataFormatter.format(endDate)
    };
  }

  factory TaskCreationUserModel.fromJson(Map<String, dynamic> json) {
    return TaskCreationUserModel(
      userId: json['user_id'] as int,
      taskUserAttId: json['task_user_att_id'] as int,
      taskPnt: json['task_pnt'] as String,
      taskCmt: json['task_cmt'] != null ? json['task_cmt'] as String : null,
      taskState: json['task_state'] as int,
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date'])
    );
  }
}