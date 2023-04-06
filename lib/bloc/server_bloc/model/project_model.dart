// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// Project Model

class ProjectModel {
  int? projectId;
  String title;
  String category;
  String description;
  String goal;
  DateTime startOn;
  DateTime? expireOn;
  ProjectModel({
    this.projectId,
    required this.title,
    required this.category,
    required this.description,
    required this.goal,
    required this.startOn,
    this.expireOn,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'project_id': projectId,
      'title': title,
      'category': category,
      'description': description,
      'goal': goal,
      'start_on': startOn.millisecondsSinceEpoch,
      'expire_on': expireOn?.millisecondsSinceEpoch,
    };
  }

  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      projectId: map['project_id'] != null ? map['project_id'] as int : null,
      title: map['title'] as String,
      category: map['category'] as String,
      description: map['description'] as String,
      goal: map['goal'] as String,
      startOn: DateTime.fromMillisecondsSinceEpoch(map['start_on'] as int),
      expireOn: map['expire_on'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['expire_on'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectModel.fromJson(String source) =>
      ProjectModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProjectModel(project_id: $projectId, title: $title, category: $category, description: $description, goal: $goal, start_on: $startOn, expire_on: $expireOn)';
  }
}

// Project Rule Model

class ProjectRuleModel {
  int? ruleId;
  int projectId;
  String rule;
  ProjectRuleModel({
    this.ruleId,
    required this.projectId,
    required this.rule,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rule_id': ruleId,
      'project_id': projectId,
      'rule': rule,
    };
  }

  factory ProjectRuleModel.fromMap(Map<String, dynamic> map) {
    return ProjectRuleModel(
      ruleId: map['rule_id'] != null ? map['rule_id'] as int : null,
      projectId: map['project_id'] as int,
      rule: map['rule'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectRuleModel.fromJson(String source) =>
      ProjectRuleModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ProjectRuleModel(rule_id: $ruleId, project_id: $projectId, rule: $rule)';
}

// Project Member Model

class ProjectMemberModel {
  int? pmemberId;
  int projectId;
  int userId;
  String role;
  ProjectMemberModel({
    this.pmemberId,
    required this.projectId,
    required this.userId,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pmember_id': pmemberId,
      'project_id': projectId,
      'user_id': userId,
      'role': role,
    };
  }

  factory ProjectMemberModel.fromMap(Map<String, dynamic> map) {
    return ProjectMemberModel(
      pmemberId: map['pmember_id'] != null ? map['pmember_id'] as int : null,
      projectId: map['project_id'] as int,
      userId: map['user_id'] as int,
      role: map['role'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectMemberModel.fromJson(String source) => ProjectMemberModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProjectMemberModel(pmember_id: $pmemberId, project_id: $projectId, user_id: $userId, role: $role)';
  }
}

// Project Overview Model


class ProjectOverViewModel {
  final int projectId;
  final String title;
  final int category;
  final String description;
  final String goal;
  final DateTime startOn;
  final DateTime expireOn;
  final int memberCount;
  final String masterName;
  final String? masterIntroduce;
  final String? masterImageUrl;

  ProjectOverViewModel({
    required this.projectId,
    required this.title,
    required this.category,
    required this.description,
    required this.goal,
    required this.startOn,
    required this.expireOn,
    required this.memberCount,
    required this.masterName,
    required this.masterIntroduce,
    required this.masterImageUrl,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'project_id': projectId,
      'title': title,
      'category': category,
      'description': description,
      'goal': goal,
      'start_on': startOn.millisecondsSinceEpoch,
      'expire_on': expireOn.millisecondsSinceEpoch,
      'member_count': memberCount,
      'master_name': masterName,
      'master_introduce': masterIntroduce,
      'master_imageUrl': masterImageUrl,
    };
  }

  factory ProjectOverViewModel.fromMap(Map<String, dynamic> json) {
    return ProjectOverViewModel(
      projectId: json['project_id'] as int,
      title: json['title'] as String,
      category: json['category'] as int,
      description: json['description'] as String,
      goal: json['goal'] as String,
      startOn: DateTime.parse(json['start_on']),
      expireOn: DateTime.parse(json['expire_on']),
      memberCount: json['member_count'] as int,
      masterName: json['master_name'] as String,
      masterIntroduce: json['master_introduce']?? "",
      masterImageUrl: json['master_imageUrl']?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectOverViewModel.fromJson(String source) => ProjectOverViewModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

