// Task Member Model
import 'dart:convert';

class TaskDetailModel {
  int? taskDtlId;
  int taskId;
  int picId;
  String? taskDtlCnt;
  int userProg;
  int? userEval;

  TaskDetailModel(
      {this.taskDtlId,
      required this.taskId,
      required this.picId,
      this.taskDtlCnt,
      required this.userProg,
      this.userEval});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'task_dtl_id': taskDtlId,
      'task_id': taskId,
      'pic_id': picId,
      'task_dtl_cnt': taskDtlCnt,
      'user_prog': userProg,
      'user_eval': userEval
    };
  }

  factory TaskDetailModel.fromMap(Map<String, dynamic> map) {
    return TaskDetailModel(
        taskDtlId: map['task_dtl_id'] != null ? map['task_dtl_id'] as int : null,
        taskId: map['task_id'] as int,
        picId: map['pic_id'] as int,
        taskDtlCnt: map['task_dtl_cnt'] != null ? map['task_dtl_cnt'] as String : null,
        userProg: map['user_prog'] as int,
        userEval: map['user_eval'] != null ? map['user_eval'] as int : null);
  }

  String toJson() => json.encode(toMap());

  factory TaskDetailModel.fromJson(String source) =>
      TaskDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
