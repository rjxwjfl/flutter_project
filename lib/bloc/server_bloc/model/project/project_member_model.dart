// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


// Project Member Model

class ProjectMemberModel {
  int? projectMemberId;
  int projectId;
  int userId;
  String role;
  ProjectMemberModel({
    this.projectMemberId,
    required this.projectId,
    required this.userId,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'project_member_id': projectMemberId,
      'project_id': projectId,
      'user_id': userId,
      'role': role,
    };
  }

  factory ProjectMemberModel.fromMap(Map<String, dynamic> map) {
    return ProjectMemberModel(
      projectMemberId: map['project_member_id'] != null ? map['project_member_id'] as int : null,
      projectId: map['project_id'] as int,
      userId: map['user_id'] as int,
      role: map['role'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectMemberModel.fromJson(String source) => ProjectMemberModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProjectMemberModel(project_member_id: $projectMemberId, project_id: $projectId, user_id: $userId, role: $role)';
  }
}

