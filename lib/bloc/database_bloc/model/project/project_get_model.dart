
import 'package:flutter_dowith/utils/convert_data.dart';
import 'package:intl/intl.dart';

class ProjectGetModel {
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
  int memberCount;

  ProjectGetModel(
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
        required this.memberCount});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'prj_id': prjId,
      'title': title,
      'category': category,
      'mst_id': mstId,
      'prj_desc': prjDesc,
      'goal': goal,
      'create_at': createAt != null ? dataFormatter.format(createAt!) : null,
      'start_on': startOn != null ? dataFormatter.format(startOn!) : null,
      'expire_on': expireOn != null ? dataFormatter.format(expireOn!) : null,
      'pvt': setInt(pvt),
      'member_count': memberCount
    };
  }

  factory ProjectGetModel.fromJson(Map<String, dynamic> json) {
    return ProjectGetModel(
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
        memberCount: json['member_count'] as int);
  }
}