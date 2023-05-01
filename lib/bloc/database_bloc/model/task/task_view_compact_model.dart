import 'package:flutter_dowith/utils/convert_data.dart';

class TaskViewCompactModel {
  int taskId;
  int prjId;
  int pubId;
  String pubName;
  String? pubImage;
  int? taskMgrId;
  String? mgrName;
  String? mgrImage;
  int? taskAttId;
  String taskSub;
  String taskDtlDesc;
  String lblClr;
  int priority;
  DateTime createAt;
  DateTime updateAt;
  bool taskPE;
  String? taskPeriod;
  DateTime? startDate;
  DateTime? endDate;
  int? taskFreq;
  int usersCount;
  
  TaskViewCompactModel({
    required this.taskId,
    required this.prjId,
    required this.pubId,
    required this.pubName,
    this.pubImage,
    this.taskMgrId,
    this.mgrName,
    this.mgrImage,
    this.taskAttId,
    required this.taskSub,
    required this.taskDtlDesc,
    required this.lblClr,
    required this.priority,
    required this.createAt,
    required this.updateAt,
    required this.taskPE,
    this.taskPeriod,
    this.startDate,
    this.endDate,
    this.taskFreq,
    required this.usersCount,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'task_id': taskId,
      'prj_id': prjId,
      'pub_id': pubId,
      'pub_name': pubName,
      'pub_image': pubImage,
      'task_mgr_id': taskMgrId,
      'mgr_name': mgrName,
      'mgr_image': mgrImage,
      'task_att_id': taskAttId,
      'task_sub': taskSub,
      'task_dtl_desc': taskDtlDesc,
      'lbl_clr': lblClr,
      'priority': priority,
      'create_at': dataFormatter.format(createAt),
      'update_at': dataFormatter.format(updateAt),
      'task_pe': setInt(taskPE),
      'task_period': taskPeriod,
      'start_date': startDate != null ? dataFormatter.format(startDate!) : null,
      'end_date': endDate != null ? dataFormatter.format(endDate!) : null,
      'task_freq': taskFreq,
      'users_count': usersCount,
    };
  }

  factory TaskViewCompactModel.fromJson(Map<String, dynamic> json) {
    return TaskViewCompactModel(
      taskId: json['task_id'] as int,
      prjId: json['prj_id'] as int,
      pubId: json['pub_id'] as int,
      pubName: json['pub_name'] as String,
      pubImage: json['pub_image'] != null ? json['pub_image'] as String : null,
      taskMgrId:
          json['task_mgr_id'] != null ? json['task_mgr_id'] as int : null,
      mgrName: json['mgr_name'] != null ? json['mgr_name'] as String : null,
      mgrImage: json['mgr_image'] != null ? json['mgr_image'] as String : null,
      taskAttId:
          json['task_att_id'] != null ? json['task_att_id'] as int : null,
      taskSub: json['task_sub'] as String,
      taskDtlDesc: json['task_dtl_desc'] as String,
      lblClr: json['lbl_clr'] as String,
      priority: json['priority'] as int,
      createAt: DateTime.parse(json['create_at'] ),
      updateAt: DateTime.parse(json['update_at'] ),
      taskPE: setBool(json['task_pe']),
      taskPeriod: json['task_period'] != null ? json['task_period'] as String : null,
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'])
          : null,
      endDate: json['end_date'] != null
          ? DateTime.parse(json['end_date'])
          : null,
      taskFreq: json['task_freq'] != null ? json['task_freq'] as int : null,
      usersCount: json['users_count'] as int,
    );
  }
}
