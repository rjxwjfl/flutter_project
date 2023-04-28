
import 'package:flutter_dowith/bloc/database_bloc/model/user/user_compact_model.dart';

import 'package:flutter_dowith/utils/convert_data.dart';

class TaskViewDetailModel {
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
  int taskFreq;
  List<UserCompactModel> users;

  TaskViewDetailModel({
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
    required this.taskFreq,
    required this.users,
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
      'create_at': formatter.format(createAt),
      'update_at': formatter.format(updateAt),
      'task_pe': setInt(taskPE),
      'task_period': taskPeriod,
      'start_date': startDate != null ? formatter.format(startDate!) : null,
      'end_date': endDate != null ? formatter.format(endDate!) : null,
      'task_freq': taskFreq,
      'users': users.map((user) => user.toJson()).toList(),
    };
  }

  factory TaskViewDetailModel.fromJson(Map<String, dynamic> json) {
    List<UserCompactModel> userList = [];
    for (var user in json['users']){
      userList.add(UserCompactModel.fromJson(user));
    }
    return TaskViewDetailModel(
        taskId: json['task_id'] as int,
        prjId: json['prj_id'] as int,
        pubId: json['pub_id'] as int,
        pubName: json['pub_name'] as String,
        pubImage:
            json['pub_image'] != null ? json['pub_image'] as String : null,
        taskMgrId:
            json['task_mgr_id'] != null ? json['task_mgr_id'] as int : null,
        mgrName: json['mgr_name'] != null ? json['mgr_name'] as String : null,
        mgrImage:
            json['mgr_image'] != null ? json['mgr_image'] as String : null,
        taskAttId:
            json['task_att_id'] != null ? json['task_att_id'] as int : null,
        taskSub: json['task_sub'] as String,
        taskDtlDesc: json['task_dtl_desc'] as String,
        lblClr: json['lbl_clr'] as String,
        priority: json['priority'] as int,
        createAt: DateTime.parse(json['create_at']),
        updateAt: DateTime.parse(json['update_at']),
        taskPE: setBool(json['task_pe']),
        taskPeriod:
            json['task_period'] != null ? json['task_period'] as String : null,
        startDate: json['start_date'] != null
            ? DateTime.parse(json['start_date'])
            : null,
        endDate:
            json['end_date'] != null ? DateTime.parse(json['end_date']) : null,
        taskFreq: json['task_freq'] as int,
        users: userList);
  }
}

