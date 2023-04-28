import 'package:flutter_dowith/utils/convert_data.dart';

// Project Model

class ProjectSetModel {
  int? prjId;
  String title;
  int category;
  String prjDesc;
  String goal;
  DateTime? createAt;
  DateTime? startOn;
  DateTime? expireOn;
  bool pvt;

  ProjectSetModel(
      {this.prjId,
      required this.title,
      required this.category,
      required this.prjDesc,
      required this.goal,
      this.createAt,
      this.startOn,
      this.expireOn,
      required this.pvt});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'prj_id': prjId,
      'title': title,
      'category': category,
      'prj_desc': prjDesc,
      'goal': goal,
      'create_at': createAt != null ? formatter.format(createAt!) : null,
      'start_on': startOn != null ? formatter.format(startOn!) : null,
      'expire_on': expireOn != null ? formatter.format(expireOn!) : null,
      'pvt': setInt(pvt)
    };
  }

  factory ProjectSetModel.fromJson(Map<String, dynamic> json) {
    return ProjectSetModel(
        prjId: json['prj_id'] != null ? json['prj_id'] as int : null,
        title: json['title'] as String,
        category: json['category'] as int,
        prjDesc: json['prj_desc'] as String,
        goal: json['goal'] as String,
        createAt: json['create_at'] != null ? DateTime.parse(json['create_at']) : null,
        startOn: json['start_on'] != null ? DateTime.parse(json['start_on']) : null,
        expireOn: json['expire_on'] != null ? DateTime.parse(json['expire_on']) : null,
        pvt: setBool(json['pvt']));
  }
}
