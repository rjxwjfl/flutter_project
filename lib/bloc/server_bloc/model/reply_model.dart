// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:intl/intl.dart';

class TaskReplyModel {
  int? taskReplyId;
  int taskCmtId;
  int authorId;
  String taskReplyCnt;
  DateTime createAt;
  DateTime updateAt;
  TaskReplyModel({
    this.taskReplyId,
    required this.taskCmtId,
    required this.authorId,
    required this.taskReplyCnt,
    required this.createAt,
    required this.updateAt,
  });

  Map<String, dynamic> toMap() {
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return <String, dynamic>{
      'task_reply_id': taskReplyId,
      'task_cmt_id': taskCmtId,
      'author_id': authorId,
      'task_reply_cnt': taskReplyCnt,
      'create_at': formatter.format(createAt),
      'update_at': formatter.format(updateAt),
    };
  }

  factory TaskReplyModel.fromMap(Map<String, dynamic> map) {
    return TaskReplyModel(
      taskReplyId: map['task_reply_id'] != null ? map['task_reply_id'] as int : null,
      taskCmtId: map['task_cmt_id'] as int,
      authorId: map['author_id'] as int,
      taskReplyCnt: map['task_reply_cnt'] as String,
      createAt: DateTime.parse(map['create_at']),
      updateAt: DateTime.parse(map['update_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskReplyModel.fromJson(String source) => TaskReplyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TaskReplyModel(task_reply_id: $taskReplyId, task_comment_id: $taskCmtId, author_id: $authorId, content: $taskReplyCnt, create_at: $createAt, update_at: $updateAt)';
  }
}

class FeedReplyModel {
  int? feedReplyId;
  int feedCommentId;
  int authorId;
  String feedReplyCnt;
  DateTime createAt;
  DateTime updateAt;
  FeedReplyModel({
    this.feedReplyId,
    required this.feedCommentId,
    required this.authorId,
    required this.feedReplyCnt,
    required this.createAt,
    required this.updateAt,
  });

  Map<String, dynamic> toMap() {
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return <String, dynamic>{
      'feed_reply_id': feedReplyId,
      'feed_cmt_id': feedCommentId,
      'author_id': authorId,
      'feed_reply_cnt': feedReplyCnt,
      'create_at': formatter.format(createAt),
      'update_at': formatter.format(updateAt),
    };
  }

  factory FeedReplyModel.fromMap(Map<String, dynamic> map) {
    return FeedReplyModel(
      feedReplyId: map['feed_reply_id'] != null ? map['feed_reply_id'] as int : null,
      feedCommentId: map['feed_cmt_id'] as int,
      authorId: map['author_id'] as int,
      feedReplyCnt: map['feed_reply_cnt'] as String,
      createAt: DateTime.parse(map['create_at']),
      updateAt: DateTime.parse(map['update_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory FeedReplyModel.fromJson(String source) => FeedReplyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FeedReplyModel(feed_reply_id: $feedReplyId, feed_comment_id: $feedCommentId, author_id: $authorId, content: $feedReplyCnt, create_at: $createAt, update_at: $updateAt)';
  }
}
