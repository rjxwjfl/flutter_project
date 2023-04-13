// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MileStoneModel {
  int? prjMsId;
  int prjId;
  int taskId;
  String msTitle;
  String msContent;
  int msState;

  MileStoneModel(
      {this.prjMsId,
      required this.prjId,
      required this.taskId,
      required this.msTitle,
      required this.msContent,
      required this.msState});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'prj_ms_id': prjMsId,
      'prj_id': prjId,
      'task_id': taskId,
      'ms_title': msTitle,
      'ms_content': msContent,
      'ms_state': msState
    };
  }

  factory MileStoneModel.fromMap(Map<String, dynamic> map) {
    return MileStoneModel(
        prjMsId: map['prj_ms_id'] != null ? map['prj_ms_id'] as int : null,
        prjId: map['prj_id'] as int,
        taskId: map['task_id'] as int,
        msTitle: map['ms_title'] as String,
        msContent: map['ms_content'] as String,
        msState: map['ms_state'] as int);
  }

  String toJson() => json.encode(toMap());

  factory MileStoneModel.fromJson(String source) => MileStoneModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
