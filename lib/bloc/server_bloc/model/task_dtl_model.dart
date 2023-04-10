
// Task Member Model
import 'dart:convert';

class TaskDetailModel {
  int taskDtlId;
  int taskId;
  int picId;
  String? description;
  int progress;
  int evaluation;
  String? taskDtlAtt;
  TaskDetailModel({
    required this.taskDtlId,
    required this.taskId,
    required this.picId,
    this.description,
    required this.progress,
    required this.evaluation,
    this.taskDtlAtt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'task_dtl_id': taskDtlId,
      'task_id': taskId,
      'pic_id': picId,
      'description': description,
      'progress': progress,
      'evaluation': evaluation,
      'task_dtl_att': taskDtlAtt,
    };
  }

  factory TaskDetailModel.fromMap(Map<String, dynamic> map) {
    return TaskDetailModel(
      taskDtlId: map['task_dtl_id'] as int,
      taskId: map['task_id'] as int,
      picId: map['pic_id'] as int,
      description: map['description'] != null ? map['description'] as String : null,
      progress: map['progress'] as int,
      evaluation: map['evaluation'] as int,
      taskDtlAtt: map['task_dtl_att'] != null ? map['task_dtl_att'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskDetailModel.fromJson(String source) => TaskDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TaskDetailModel(task_dtl_id: $taskDtlId, task_id: $taskId, pic_id: $picId, description: $description, progress: $progress, evaluation: $evaluation, task_dtl_att: $taskDtlAtt)';
  }
}
