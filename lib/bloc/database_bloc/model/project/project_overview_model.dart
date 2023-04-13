// Project Overview Model

import 'dart:convert';

import 'package:flutter_dowith/bloc/database_bloc/model/user/user_dtl_model.dart';
import 'package:intl/intl.dart';

class ProjectOverViewModel {
  final int prjId;
  final String title;
  final int category;
  final String prjDesc;
  final String goal;
  final DateTime? startOn;
  final DateTime? expireOn;
  final int memberCount;
  final String masterName;
  final String? masterIntroduce;
  final String? masterImageUrl;
  final bool pvt;

  ProjectOverViewModel(
      {required this.prjId,
      required this.title,
      required this.category,
      required this.prjDesc,
      required this.goal,
      this.startOn,
      this.expireOn,
      required this.memberCount,
      required this.masterName,
      required this.masterIntroduce,
      required this.masterImageUrl,
      required this.pvt});

  Map<String, dynamic> toMap() {
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return <String, dynamic>{
      'prj_id': prjId,
      'title': title,
      'category': category,
      'prj_desc': prjDesc,
      'goal': goal,
      'start_on': formatter.format(startOn!),
      'expire_on': formatter.format(expireOn!),
      'member_count': memberCount,
      'master_name': masterName,
      'master_introduce': masterIntroduce,
      'master_imageUrl': masterImageUrl,
      'pvt': setInt(pvt)
    };
  }

  factory ProjectOverViewModel.fromMap(Map<String, dynamic> json) {
    return ProjectOverViewModel(
        prjId: json['prj_id'] as int,
        title: json['title'] as String,
        category: json['category'] as int,
        prjDesc: json['prj_desc'] as String,
        goal: json['goal'] as String,
        startOn: json['start_on'] != null ? DateTime.parse(json['start_on']) : null,
        expireOn: json['expire_on'] != null ? DateTime.parse(json['expire_on']) : null,
        memberCount: json['member_count'] as int,
        masterName: json['master_name'] as String,
        masterIntroduce: json['master_introduce'] ?? "",
        masterImageUrl: json['master_imageUrl'] ?? "",
        pvt: setBool(json['pvt'])
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectOverViewModel.fromJson(String source) =>
      ProjectOverViewModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
