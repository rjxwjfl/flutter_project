
// Task Member Model
import 'dart:convert';

class TaskDetailModel {
  int? taskDtlId;
  int taskId;
  int picId;
  String? taskDtlCnt;
  int userProg;
  int? userEval;
  String? taskDtlAtt;
  TaskDetailModel({
    this.taskDtlId,
    required this.taskId,
    required this.picId,
    this.taskDtlCnt,
    required this.userProg,
    this.userEval,
    this.taskDtlAtt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'task_dtl_id': taskDtlId,
      'task_id': taskId,
      'pic_id': picId,
      'task_dtl_cnt': taskDtlCnt,
      'user_prog': userProg,
      'user_eval': userEval,
      'task_dtl_att': taskDtlAtt,
    };
  }

  factory TaskDetailModel.fromMap(Map<String, dynamic> map) {
    return TaskDetailModel(
      taskDtlId: map['task_dtl_id'] != null ? map['task_dtl_id'] as int : null,
      taskId: map['task_id'] as int,
      picId: map['pic_id'] as int,
      taskDtlCnt: map['task_dtl_cnt'] != null ? map['task_dtl_cnt'] as String : null,
      userProg: map['user_prog'] as int,
      userEval: map['user_eval'] != null ? map['user_eval'] as int : null,
      taskDtlAtt: map['task_dtl_att'] != null ? map['task_dtl_att'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskDetailModel.fromJson(String source) => TaskDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TaskDetailModel(task_dtl_id: $taskDtlId, task_id: $taskId, pic_id: $picId, description: $taskDtlCnt, progress: $userProg, evaluation: $userEval, task_dtl_att: $taskDtlAtt)';
  }
}
