// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_dowith/bloc/database_bloc/model/user/user_dtl_model.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icon.dart';

// Project Model

class ProjectModel {
  int? prjId;
  String title;
  int category;
  int mstId;
  String prjDesc;
  String goal;
  DateTime? createAt;
  DateTime? startOn;
  DateTime? expireOn;
  bool pvt;
  String? prjPw;

  ProjectModel(
      {this.prjId,
      required this.title,
      required this.category,
      required this.mstId,
      required this.prjDesc,
      required this.goal,
      this.createAt,
      this.startOn,
      this.expireOn,
      required this.pvt,
      this.prjPw});

  Map<String, dynamic> toMap() {
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return <String, dynamic>{
      'prj_id': prjId,
      'title': title,
      'category': category,
      'mst_id': mstId,
      'prj_desc': prjDesc,
      'goal': goal,
      'create_at': createAt != null ? formatter.format(createAt!) : null,
      'start_on': startOn != null ? formatter.format(startOn!) : null,
      'expire_on': expireOn != null ? formatter.format(expireOn!) : null,
      'pvt': setInt(pvt),
      'prj_pw': prjPw
    };
  }

  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
        prjId: map['prj_id'] != null ? map['prj_id'] as int : null,
        title: map['title'] as String,
        category: map['category'] as int,
        mstId: map['mst_id'] as int,
        prjDesc: map['prj_desc'] as String,
        goal: map['goal'] as String,
        createAt: map['create_at'] != null ? DateTime.parse(map['create_at']) : null,
        startOn: map['start_on'] != null ? DateTime.parse(map['start_on']) : null,
        expireOn: map['expire_on'] != null ? DateTime.parse(map['expire_on']) : null,
        pvt: setBool(map['pvt']),
        prjPw: map['prj_pw'] != null ? map['prj_pw'] as String : null);
  }

  String toJson() => json.encode(toMap());

  factory ProjectModel.fromJson(String source) => ProjectModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
