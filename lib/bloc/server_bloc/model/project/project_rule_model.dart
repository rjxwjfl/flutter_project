
// Project Rule Model

import 'dart:convert';

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
