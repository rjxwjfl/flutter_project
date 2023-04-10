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
