// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// Project Member Model

class ProjectMemberModel {
  int? prjMbrId;
  int prjId;
  int userId;
  int role;

  ProjectMemberModel({this.prjMbrId, required this.prjId, required this.userId, required this.role});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'prj_mbr_id': prjMbrId, 'prj_id': prjId, 'user_id': userId, 'role': role};
  }

  factory ProjectMemberModel.fromMap(Map<String, dynamic> map) {
    return ProjectMemberModel(
        prjMbrId: map['prj_mbr_id'] != null ? map['prj_mbr_id'] as int : null,
        prjId: map['prj_id'] as int,
        userId: map['user_id'] as int,
        role: map['role'] as int);
  }

  String toJson() => json.encode(toMap());

  factory ProjectMemberModel.fromJson(String source) =>
      ProjectMemberModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
