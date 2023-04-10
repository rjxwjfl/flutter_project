// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TaskReplyModel {
  int taskReplyId;
  int taskCommentId;
  int authorId;
  String content;
  DateTime createAt;
  DateTime updateAt;
  TaskReplyModel({
    required this.taskReplyId,
    required this.taskCommentId,
    required this.authorId,
    required this.content,
    required this.createAt,
    required this.updateAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'task_reply_id': taskReplyId,
      'task_comment_id': taskCommentId,
      'author_id': authorId,
      'content': content,
      'create_at': createAt.millisecondsSinceEpoch,
      'update_at': updateAt.millisecondsSinceEpoch,
    };
  }

  factory TaskReplyModel.fromMap(Map<String, dynamic> map) {
    return TaskReplyModel(
      taskReplyId: map['task_reply_id'] as int,
      taskCommentId: map['task_comment_id'] as int,
      authorId: map['author_id'] as int,
      content: map['content'] as String,
      createAt: DateTime.fromMillisecondsSinceEpoch(map['create_at'] as int),
      updateAt: DateTime.fromMillisecondsSinceEpoch(map['update_at'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskReplyModel.fromJson(String source) => TaskReplyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TaskReplyModel(task_reply_id: $taskReplyId, task_comment_id: $taskCommentId, author_id: $authorId, content: $content, create_at: $createAt, update_at: $updateAt)';
  }
}

class FeedReplyModel {
  int feedReplyId;
  int feedCommentId;
  int authorId;
  String content;
  DateTime createAt;
  DateTime updateAt;
  FeedReplyModel({
    required this.feedReplyId,
    required this.feedCommentId,
    required this.authorId,
    required this.content,
    required this.createAt,
    required this.updateAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'feed_reply_id': feedReplyId,
      'feed_comment_id': feedCommentId,
      'author_id': authorId,
      'content': content,
      'create_at': createAt.millisecondsSinceEpoch,
      'update_at': updateAt.millisecondsSinceEpoch,
    };
  }

  factory FeedReplyModel.fromMap(Map<String, dynamic> map) {
    return FeedReplyModel(
      feedReplyId: map['feed_reply_id'] as int,
      feedCommentId: map['feed_comment_id'] as int,
      authorId: map['author_id'] as int,
      content: map['content'] as String,
      createAt: DateTime.fromMillisecondsSinceEpoch(map['create_at'] as int),
      updateAt: DateTime.fromMillisecondsSinceEpoch(map['update_at'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory FeedReplyModel.fromJson(String source) => FeedReplyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FeedReplyModel(feed_reply_id: $feedReplyId, feed_comment_id: $feedCommentId, author_id: $authorId, content: $content, create_at: $createAt, update_at: $updateAt)';
  }
}
