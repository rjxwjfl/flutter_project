
// Project Overview Model

import 'dart:convert';

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

