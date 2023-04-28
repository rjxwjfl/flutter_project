
class UserTaskModel {
  int userTaskId;
  int userId;
  int taskId;

  UserTaskModel({required this.userTaskId, required this.userId, required this.taskId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'user_task_id': userTaskId, 'user_id': userId, 'task_id': taskId};
  }

  factory UserTaskModel.fromMap(Map<String, dynamic> map) {
    return UserTaskModel(
        userTaskId: map['user_task_id'] as int, userId: map['user_id'] as int, taskId: map['task_id'] as int);
  }
}
