// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// Task Model
class TaskModel {
  int? taskId;
  int projectId;
  int authorId;
  String title;
  String? description;
  DateTime createAt;
  DateTime updateAt;
  DateTime startOn;
  DateTime deadline;
  TaskModel({
    this.taskId,
    required this.projectId,
    required this.authorId,
    required this.title,
    this.description,
    required this.createAt,
    required this.updateAt,
    required this.startOn,
    required this.deadline,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'task_id': taskId,
      'project_id': projectId,
      'author_id': authorId,
      'title': title,
      'description': description,
      'create_at': createAt.millisecondsSinceEpoch,
      'update_at': updateAt.millisecondsSinceEpoch,
      'start_on': startOn.millisecondsSinceEpoch,
      'deadline': deadline.millisecondsSinceEpoch,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      taskId: map['task_id'] != null ? map['task_id'] as int : null,
      projectId: map['project_id'] as int,
      authorId: map['author_id'] as int,
      title: map['title'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      createAt: DateTime.fromMillisecondsSinceEpoch(map['create_at'] as int),
      updateAt: DateTime.fromMillisecondsSinceEpoch(map['update_at'] as int),
      startOn: DateTime.fromMillisecondsSinceEpoch(map['start_on'] as int),
      deadline: DateTime.fromMillisecondsSinceEpoch(map['deadline'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TaskModel(task_id: $taskId, project_id: $projectId, author_id: $authorId, title: $title, description: $description, create_at: $createAt, update_at: $updateAt, start_on: $startOn, deadline: $deadline)';
  }
}

// Task Member Model
class TaskMemberModel {
  int? tmembersId;
  int taskId;
  int userId;
  int progress;
  int evaluation;
  TaskMemberModel({
    this.tmembersId,
    required this.taskId,
    required this.userId,
    required this.progress,
    required this.evaluation,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tmembers_id': tmembersId,
      'task_id': taskId,
      'user_id': userId,
      'progress': progress,
      'evaluation': evaluation,
    };
  }

  factory TaskMemberModel.fromMap(Map<String, dynamic> map) {
    return TaskMemberModel(
      tmembersId:
          map['tmembers_id'] != null ? map['tmembers_id'] as int : null,
      taskId: map['task_id'] as int,
      userId: map['user_id'] as int,
      progress: map['progress'] as int,
      evaluation: map['evaluation'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskMemberModel.fromJson(String source) =>
      TaskMemberModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TaskMemberModel(tmembers_id: $tmembersId, task_id: $taskId, user_id: $userId, progress: $progress, evaluation: $evaluation)';
  }
}

// Task Comment Model
class TaskCommentModel {
  int? tcommentsId;
  int taskId;
  String content;
  DateTime createAt;
  DateTime updateAt;
  TaskCommentModel({
    this.tcommentsId,
    required this.taskId,
    required this.content,
    required this.createAt,
    required this.updateAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tcomments_id': tcommentsId,
      'task_id': taskId,
      'content': content,
      'create_at': createAt.millisecondsSinceEpoch,
      'update_at': updateAt.millisecondsSinceEpoch,
    };
  }

  factory TaskCommentModel.fromMap(Map<String, dynamic> map) {
    return TaskCommentModel(
      tcommentsId: map['tcomments_id'] != null ? map['tcomments_id'] as int : null,
      taskId: map['task_id'] as int,
      content: map['content'] as String,
      createAt: DateTime.fromMillisecondsSinceEpoch(map['create_at'] as int),
      updateAt: DateTime.fromMillisecondsSinceEpoch(map['update_at'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskCommentModel.fromJson(String source) => TaskCommentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TaskCommentModel(tcomments_id: $tcommentsId, task_id: $taskId, content: $content, create_at: $createAt, update_at: $updateAt)';
  }
}
