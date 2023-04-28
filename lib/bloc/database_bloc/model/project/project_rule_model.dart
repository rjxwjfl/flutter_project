
class ProjectRuleModel {
  int? ruleId;
  int prjId;
  String rule;

  ProjectRuleModel({this.ruleId, required this.prjId, required this.rule});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'rule_id': ruleId, 'prj_id': prjId, 'rule': rule};
  }

  factory ProjectRuleModel.fromJson(Map<String, dynamic> json) {
    return ProjectRuleModel(
        ruleId: json['rule_id'] != null ? json['rule_id'] as int : null,
        prjId: json['prj_id'] as int,
        rule: json['rule'] as String);
  }
}
