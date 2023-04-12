// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserTaskModel {
  int userTaskId;
  int userId;
  int taskId;
  UserTaskModel({
    required this.userTaskId,
    required this.userId,
    required this.taskId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_task_id': userTaskId,
      'user_id': userId,
      'task_id': taskId,
    };
  }

  factory UserTaskModel.fromMap(Map<String, dynamic> map) {
    return UserTaskModel(
      userTaskId: map['user_task_id'] as int,
      userId: map['user_id'] as int,
      taskId: map['task_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserTaskModel.fromJson(String source) => UserTaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserTaskModel(user_task_id: $userTaskId, user_id: $userId, task_id: $taskId)';
}
