
import 'package:flutter_dowith/utils/convert_data.dart';

class TaskCreationModel {
  int pubId;
  int? taskMgrId;
  String taskSub;
  String lblClr;
  int priority;
  int? taskAttId;
  String taskDtlDesc;
  bool taskPE;
  String? taskPeriod;
  DateTime? startDate;
  DateTime? endDate;
  int? taskFreq;
  List<TaskCreationModel>? users;

  TaskCreationModel({
    required this.pubId,
    this.taskMgrId,
    required this.taskSub,
    required this.lblClr,
    required this.priority,
    this.taskAttId,
    required this.taskDtlDesc,
    required this.taskPE,
    this.taskPeriod,
    this.startDate,
    this.endDate,
    this.taskFreq,
    this.users,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'pub_id': pubId,
      'task_mgr_id': taskMgrId,
      'task_sub': taskSub,
      'lbl_clr': lblClr,
      'priority': priority,
      'task_att_id': taskAttId,
      'task_dtl_desc': taskDtlDesc,
      'task_pe': setInt(taskPE),
      'task_period': taskPeriod,
      'start_date': startDate != null ? dataFormatter.format(startDate!) : null,
      'end_date': endDate != null ? dataFormatter.format(endDate!) : null,
      'task_freq': taskFreq,
      'users':
          users != null ? users!.map((user) => user.toJson()).toList() : null,
    };
  }

  factory TaskCreationModel.fromJson(Map<String, dynamic> json) {
    List<TaskCreationModel> userList = [];
    if (json['users'] != null) {
      for (var user in json['users']) {
        userList.add(TaskCreationModel.fromJson(user));
      }
    }
    return TaskCreationModel(
      pubId: json['pub_id'] as int,
      taskMgrId:
          json['task_mgr_id'] != null ? json['task_mgr_id'] as int : null,
      taskSub: json['task_sub'] as String,
      lblClr: json['lbl_clr'] as String,
      priority: json['priority'] as int,
      taskAttId:
          json['task_att_id'] != null ? json['task_att_id'] as int : null,
      taskDtlDesc: json['task_dtl_desc'] as String,
      taskPE: json['task_pe'] as bool,
      taskPeriod:
          json['task_period'] != null ? json['task_period'] as String : null,
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'])
          : null,
      endDate:
          json['end_date'] != null ? DateTime.parse(json['end_date']) : null,
      taskFreq: json['task_freq'] != null ? json['task_freq'] as int : null,
      users: userList.isNotEmpty ? userList : null,
    );
  }
}
