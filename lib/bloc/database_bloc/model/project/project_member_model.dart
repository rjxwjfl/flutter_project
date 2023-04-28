
class ProjectMemberModel {
  int? prjMbrId;
  int prjId;
  int userId;
  int role;

  ProjectMemberModel({this.prjMbrId, required this.prjId, required this.userId, required this.role});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'prj_mbr_id': prjMbrId, 'prj_id': prjId, 'user_id': userId, 'role': role};
  }

  factory ProjectMemberModel.fromJson(Map<String, dynamic> json) {
    return ProjectMemberModel(
        prjMbrId: json['prj_mbr_id'] != null ? json['prj_mbr_id'] as int : null,
        prjId: json['prj_id'] as int,
        userId: json['user_id'] as int,
        role: json['role'] as int);
  }
}
