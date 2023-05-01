import 'package:flutter/material.dart';

import 'package:flutter_dowith/utils/convert_data.dart';

class TaskAssignedCompactView {
  int prjId;
  int taskId;
  int pubId;
  int taskAsgdId;
  String pubName;
  int? taskMgrId;
  String? mgrName;
  String taskSub;
  Color lblClr;
  int priority;
  String taskPnt;
  String? taskCmt;
  int taskState;
  DateTime createAt;
  DateTime updateAt;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? cmplDate;

  TaskAssignedCompactView({
    required this.prjId,
    required this.taskId,
    required this.pubId,
    required this.taskAsgdId,
    required this.pubName,
    this.taskMgrId,
    this.mgrName,
    required this.taskSub,
    required this.lblClr,
    required this.priority,
    required this.taskPnt,
    this.taskCmt,
    required this.taskState,
    required this.createAt,
    required this.updateAt,
    this.startDate,
    this.endDate,
    this.cmplDate,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'prj_id': prjId,
      'task_id': taskId,
      'pub_id': pubId,
      'task_asgd_id': taskAsgdId,
      'pub_name': pubName,
      'task_mgr_id': taskMgrId,
      'mgr_name': mgrName,
      'task_sub': taskSub,
      'lbl_clr': setCode(lblClr),
      'priority': priority,
      'task_pnt': taskPnt,
      'task_cmt': taskCmt,
      'task_state': taskState,
      'create_at': dataFormatter.format(createAt),
      'update_at': dataFormatter.format(updateAt),
      'start_date': startDate != null ? dataFormatter.format(startDate!) : null,
      'end_date': endDate != null ? dataFormatter.format(endDate!) : null,
      'cmpl_date': cmplDate != null ? dataFormatter.format(cmplDate!) : null,
    };
  }

  factory TaskAssignedCompactView.fromJson(Map<String, dynamic> json) {
    return TaskAssignedCompactView(
      prjId: json['prj_id'] as int,
      taskId: json['task_id'] as int,
      pubId: json['pub_id'] as int,
      taskAsgdId: json['task_asgd_id'] as int,
      pubName: json['pub_name'] as String,
      taskMgrId:
          json['task_mgr_id'] != null ? json['task_mgr_id'] as int : null,
      mgrName: json['mgr_name'] != null ? json['mgr_name'] as String : null,
      taskSub: json['task_sub'] as String,
      lblClr: setColor(json['lbl_clr']),
      priority: json['priority'] as int,
      taskPnt: json['task_pnt'] as String,
      taskCmt: json['task_cmt'] != null ? json['task_cmt'] as String : null,
      taskState: json['task_state'] as int,
      createAt: DateTime.parse(json['create_at']),
      updateAt: DateTime.parse(json['update_at']),
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'])
          : null,
      endDate:
          json['end_date'] != null ? DateTime.parse(json['end_date']) : null,
      cmplDate:
          json['cmpl_date'] != null ? DateTime.parse(json['cmpl_date']) : null,
    );
  }
}
