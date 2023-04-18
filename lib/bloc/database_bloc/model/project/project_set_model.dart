// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_dowith/bloc/database_bloc/model/user/user_dtl_model.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icon.dart';

// Project Model

class ProjectSetModel {
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

  ProjectSetModel(
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

  factory ProjectSetModel.fromMap(Map<String, dynamic> json) {
    return ProjectSetModel(
        prjId: json['prj_id'] != null ? json['prj_id'] as int : null,
        title: json['title'] as String,
        category: json['category'] as int,
        mstId: json['mst_id'] as int,
        prjDesc: json['prj_desc'] as String,
        goal: json['goal'] as String,
        createAt: json['create_at'] != null ? DateTime.parse(json['create_at']) : null,
        startOn: json['start_on'] != null ? DateTime.parse(json['start_on']) : null,
        expireOn: json['expire_on'] != null ? DateTime.parse(json['expire_on']) : null,
        pvt: setBool(json['pvt']),
        prjPw: json['prj_pw'] != null ? json['prj_pw'] as String : null);
  }

  String toJson() => json.encode(toMap());

  factory ProjectSetModel.fromJson(String source) => ProjectSetModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
