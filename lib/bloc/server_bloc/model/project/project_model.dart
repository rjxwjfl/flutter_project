// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:intl/intl.dart';

// Project Model

class ProjectModel {
  int? prjId;
  String title;
  String category;
  String prjDesc;
  String goal;
  DateTime createAt;
  DateTime? startOn;
  DateTime? expireOn;
  int pvt;
  String? prjPw;
  ProjectModel({
    this.prjId,
    required this.title,
    required this.category,
    required this.prjDesc,
    required this.goal,
    required this.createAt,
    this.startOn,
    this.expireOn,
    required this.pvt,
    this.prjPw,
  });

  Map<String, dynamic> toMap() {
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return <String, dynamic>{
      'prj_id': prjId,
      'title': title,
      'category': category,
      'prj_desc': prjDesc,
      'goal': goal,
      'create_at': formatter.format(createAt),
      'start_on': formatter.format(startOn!),
      'expire_on': formatter.format(expireOn!),
      'pvt': pvt,
      'prj_pw': prjPw,
    };
  }

  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      prjId: map['prj_id'] != null ? map['prj_id'] as int : null,
      title: map['title'] as String,
      category: map['category'] as String,
      prjDesc: map['prj_desc'] as String,
      goal: map['goal'] as String,
      createAt: DateTime.parse(map['create_at']),
      startOn: map['start_on'] != null ?  DateTime.parse(map['start_on']) : null,
      expireOn: map['expire_on'] != null ? DateTime(map['expire_on']) : null,
      pvt: map['pvt'] as int,
      prjPw: map['prj_pw'] != null ? map['prj_pw'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectModel.fromJson(String source) => ProjectModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProjectModel(prj_id: $prjId, title: $title, category: $category, prj_desc: $prjDesc, goal: $goal, create_at: $createAt, start_on: $startOn, expire_on: $expireOn, pvt: $pvt, prj_pw: $prjPw)';
  }
}
