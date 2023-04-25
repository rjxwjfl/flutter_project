import 'dart:convert';

class TaskCompactViewModel {
  int? taskId;
  int prjId;
  int authorId;
  int? managerId;
  String title;
  String? taskDesc;
  DateTime createAt;
  DateTime updateAt;
  DateTime? completeAt;
  DateTime startOn;
  DateTime expireOn;
  int taskState;
  String authorName;
  String? authorImageUrl;
  String? managerName;
  String? managerImageUrl;

  TaskCompactViewModel({
    this.taskId,
    required this.prjId,
    required this.authorId,
    this.managerId,
    required this.title,
    this.taskDesc,
    required this.createAt,
    required this.updateAt,
    this.completeAt,
    required this.startOn,
    required this.expireOn,
    required this.taskState,
    required this.authorName,
    this.authorImageUrl,
    this.managerName,
    this.managerImageUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'task_id': taskId,
      'prj_id': prjId,
      'author_id': authorId,
      'manager_id': managerId,
      'title': title,
      'task_desc': taskDesc,
      'create_at': createAt.millisecondsSinceEpoch,
      'update_at': updateAt.millisecondsSinceEpoch,
      'complete_at': completeAt?.millisecondsSinceEpoch,
      'start_on': startOn.millisecondsSinceEpoch,
      'expire_on': expireOn.millisecondsSinceEpoch,
      'task_state': taskState,
      'author_name': authorName,
      'author_image_url': authorImageUrl,
      'manager_name': managerName,
      'manager_image_url': managerImageUrl,
    };
  }

  factory TaskCompactViewModel.fromMap(Map<String, dynamic> map) {
    return TaskCompactViewModel(
      taskId: map['task_id'] != null ? map['task_id'] as int : null,
      prjId: map['prj_id'] as int,
      authorId: map['author_id'] as int,
      managerId: map['manager_id'] != null ? map['manager_id'] as int : null,
      title: map['title'] as String,
      taskDesc: map['task_desc'] != null ? map['task_desc'] as String : null,
      createAt: DateTime.parse(map['create_at']),
      updateAt: DateTime.parse(map['update_at']),
      completeAt: map['complete_at'] != null
          ? DateTime.parse(map['complete_at'])
          : null,
      startOn: DateTime.parse(map['start_on']),
      expireOn: DateTime.parse(map['expire_on']),
      taskState: map['task_state'] as int,
      authorName: map['author_name'] as String,
      authorImageUrl: map['author_image_url'] != null ? map['author_image_url'] as String : null,
      managerName:
          map['manager_name'] != null ? map['manager_name'] as String : null,
      managerImageUrl: map['manager_image_url'] != null
          ? map['manager_image_url'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskCompactViewModel.fromJson(String source) =>
      TaskCompactViewModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
