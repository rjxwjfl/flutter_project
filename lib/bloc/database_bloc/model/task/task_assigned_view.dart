
import 'package:flutter_dowith/utils/convert_data.dart';

class TaskAssignedView {
  int taskAsgdId;
  int taskId;
  int taskAsgdAttId;
  String taskPnt;
  String taskCmt;
  int taskState;
  DateTime createAt;
  DateTime updateAt;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? cmplDate;
  
  TaskAssignedView({
    required this.taskAsgdId,
    required this.taskId,
    required this.taskAsgdAttId,
    required this.taskPnt,
    required this.taskCmt,
    required this.taskState,
    required this.createAt,
    required this.updateAt,
    this.startDate,
    this.endDate,
    this.cmplDate,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'task_asgd_id': taskAsgdId,
      'task_id': taskId,
      'task_asgd_att_id': taskAsgdAttId,
      'task_pnt': taskPnt,
      'task_cmt': taskCmt,
      'task_state': taskState,
      'create_at': formatter.format(createAt),
      'update_at': formatter.format(updateAt),
      'start_date': startDate != null ? formatter.format(startDate!) : null,
      'end_date': endDate != null ? formatter.format(endDate!) : null,
      'cmpl_date': cmplDate != null ? formatter.format(cmplDate!) : null,
    };
  }

  factory TaskAssignedView.fromJson(Map<String, dynamic> json) {
    return TaskAssignedView(
      taskAsgdId: json['task_asgd_id'] as int,
      taskId: json['task_id'] as int,
      taskAsgdAttId: json['task_asgd_att_id'] as int,
      taskPnt: json['task_pnt'] as String,
      taskCmt: json['task_cmt'] as String,
      taskState: json['task_state'] as int,
      createAt: DateTime.parse(json['create_at'] ),
      updateAt: DateTime.parse(json['update_at'] ),
      startDate: json['start_date'] != null ? DateTime.parse(json['start_date'] ) : null,
      endDate: json['end_date'] != null ? DateTime.parse(json['end_date'] ) : null,
      cmplDate: json['cmpl_date'] != null ? DateTime.parse(json['cmpl_date'] ) : null,
    );
  }
}
