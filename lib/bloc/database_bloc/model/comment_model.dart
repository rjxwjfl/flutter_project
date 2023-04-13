// ignore_for_file: public_member_api_docs, sort_constructors_first

// Task Comment Model
import 'dart:convert';

import 'package:intl/intl.dart';

class TaskCommentModel {
  int? taskCmtId;
  int taskId;
  int authorId;
  String taskCmtCnt;
  DateTime createAt;
  DateTime updateAt;

  TaskCommentModel(
      {this.taskCmtId,
      required this.taskId,
      required this.authorId,
      required this.taskCmtCnt,
      required this.createAt,
      required this.updateAt});

  Map<String, dynamic> toMap() {
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return <String, dynamic>{
      'task_cmt_id': taskCmtId,
      'taskId': taskId,
      'author_id': authorId,
      'task_cmt_cnt': taskCmtCnt,
      'createAt': formatter.format(createAt),
      'updateAt': formatter.format(updateAt)
    };
  }

  factory TaskCommentModel.fromMap(Map<String, dynamic> map) {
    return TaskCommentModel(
        taskCmtId: map['task_cmt_id'] != null ? map['task_cmt_id'] as int : null,
        taskId: map['taskId'] as int,
        authorId: map['author_id'] as int,
        taskCmtCnt: map['task_cmt_cnt'] as String,
        createAt: DateTime.parse(map['createAt']),
        updateAt: DateTime.parse(map['updateAt']));
  }

  String toJson() => json.encode(toMap());

  factory TaskCommentModel.fromJson(String source) =>
      TaskCommentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

// Feed Comment Model
class FeedCommentModel {
  int? feedCmtId;
  int feedId;
  int authorId;
  String feedCmtCnt;
  DateTime createAt;
  DateTime updateAt;

  FeedCommentModel(
      {this.feedCmtId,
      required this.feedId,
      required this.authorId,
      required this.feedCmtCnt,
      required this.createAt,
      required this.updateAt});

  Map<String, dynamic> toMap() {
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return <String, dynamic>{
      'feed_cmt_id': feedCmtId,
      'feedId': feedId,
      'author_id': authorId,
      'feed_cmt_cnt': feedCmtCnt,
      'create_at': formatter.format(createAt),
      'update_at': formatter.format(updateAt)
    };
  }

  factory FeedCommentModel.fromMap(Map<String, dynamic> map) {
    return FeedCommentModel(
        feedCmtId: map['feed_cmt_id'] != null ? map['feed_cmt_id'] as int : null,
        feedId: map['feedId'] as int,
        authorId: map['author_id'] as int,
        feedCmtCnt: map['feed_cmt_cnt'] as String,
        createAt: DateTime.parse(map['create_at']),
        updateAt: DateTime.parse(map['update_at']));
  }

  String toJson() => json.encode(toMap());

  factory FeedCommentModel.fromJson(String source) =>
      FeedCommentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
