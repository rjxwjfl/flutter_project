// Project Rule Model

import 'dart:convert';

class ProjectRuleModel {
  int? ruleId;
  int prjId;
  String rule;

  ProjectRuleModel({this.ruleId, required this.prjId, required this.rule});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'rule_id': ruleId, 'prj_id': prjId, 'rule': rule};
  }

  factory ProjectRuleModel.fromMap(Map<String, dynamic> map) {
    return ProjectRuleModel(
        ruleId: map['rule_id'] != null ? map['rule_id'] as int : null,
        prjId: map['prj_id'] as int,
        rule: map['rule'] as String);
  }

  String toJson() => json.encode(toMap());

  factory ProjectRuleModel.fromJson(String source) =>
      ProjectRuleModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
