// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// Task Model
class TaskModel {
  int taskId;
  int projectId;
  int authorId;
  int? managerId;
  String title;
  String? description;
  DateTime createAt;
  DateTime updateAt;
  DateTime? completeAt;
  DateTime startOn;
  DateTime expireOn;
  int taskState;
  String? taskAtt;
  TaskModel({
    required this.taskId,
    required this.projectId,
    required this.authorId,
    this.managerId,
    required this.title,
    this.description,
    required this.createAt,
    required this.updateAt,
    this.completeAt,
    required this.startOn,
    required this.expireOn,
    required this.taskState,
    this.taskAtt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'task_id': taskId,
      'project_id': projectId,
      'author_id': authorId,
      'manager_id': managerId,
      'title': title,
      'description': description,
      'create_at': createAt.millisecondsSinceEpoch,
      'update_at': updateAt.millisecondsSinceEpoch,
      'complete_at': completeAt?.millisecondsSinceEpoch,
      'start_on': startOn.millisecondsSinceEpoch,
      'expire_on': expireOn.millisecondsSinceEpoch,
      'task_state': taskState,
      'task_att': taskAtt,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      taskId: map['task_id'] as int,
      projectId: map['project_id'] as int,
      authorId: map['author_id'] as int,
      managerId: map['manager_id'] != null ? map['manager_id'] as int : null,
      title: map['title'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      createAt: DateTime.fromMillisecondsSinceEpoch(map['create_at'] as int),
      updateAt: DateTime.fromMillisecondsSinceEpoch(map['update_at'] as int),
      completeAt: map['complete_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['complete_at'] as int)
          : null,
      startOn: DateTime.fromMillisecondsSinceEpoch(map['start_on'] as int),
      expireOn: DateTime.fromMillisecondsSinceEpoch(map['expire_on'] as int),
      taskState: map['task_state'] as int,
      taskAtt: map['task_att'] != null ? map['task_att'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TaskModel(task_id: $taskId, project_id: $projectId, author_id: $authorId, manager_id: $managerId, title: $title, description: $description, create_at: $createAt, update_at: $updateAt, complete_at: $completeAt, start_on: $startOn, expire_on: $expireOn, task_state: $taskState, task_att: $taskAtt)';
  }
}


