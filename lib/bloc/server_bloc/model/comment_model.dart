// ignore_for_file: public_member_api_docs, sort_constructors_first

// Task Comment Model
import 'dart:convert';

class TaskCommentModel {
  int? taskCommentId;
  int taskId;
  int authorId;
  String content;
  DateTime createAt;
  DateTime updateAt;
  TaskCommentModel({
    this.taskCommentId,
    required this.taskId,
    required this.authorId,
    required this.content,
    required this.createAt,
    required this.updateAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'taskCommentId': taskCommentId,
      'taskId': taskId,
      'author_id': authorId,
      'content': content,
      'createAt': createAt.millisecondsSinceEpoch,
      'updateAt': updateAt.millisecondsSinceEpoch,
    };
  }

  factory TaskCommentModel.fromMap(Map<String, dynamic> map) {
    return TaskCommentModel(
      taskCommentId:
          map['taskCommentId'] != null ? map['taskCommentId'] as int : null,
      taskId: map['taskId'] as int,
      authorId: map['author_id'] as int,
      content: map['content'] as String,
      createAt: DateTime.fromMillisecondsSinceEpoch(map['createAt'] as int),
      updateAt: DateTime.fromMillisecondsSinceEpoch(map['updateAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskCommentModel.fromJson(String source) =>
      TaskCommentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TaskCommentModel(taskCommentId: $taskCommentId, taskId: $taskId, author_id: $authorId, content: $content, createAt: $createAt, updateAt: $updateAt)';
  }
}

// Feed Comment Model
class FeedCommentModel {
  int? feedCommentId;
  int feedId;
  int authorId;
  String content;
  DateTime createAt;
  DateTime updateAt;
  FeedCommentModel({
    this.feedCommentId,
    required this.feedId,
    required this.authorId,
    required this.content,
    required this.createAt,
    required this.updateAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'feedCommentId': feedCommentId,
      'feedId': feedId,
      'author_id': authorId,
      'content': content,
      'create_at': createAt.millisecondsSinceEpoch,
      'update_at': updateAt.millisecondsSinceEpoch,
    };
  }

  factory FeedCommentModel.fromMap(Map<String, dynamic> map) {
    return FeedCommentModel(
      feedCommentId: map['feedCommentId'] != null ? map['feedCommentId'] as int : null,
      feedId: map['feedId'] as int,
      authorId: map['author_id'] as int,
      content: map['content'] as String,
      createAt: DateTime.fromMillisecondsSinceEpoch(map['create_at'] as int),
      updateAt: DateTime.fromMillisecondsSinceEpoch(map['update_at'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory FeedCommentModel.fromJson(String source) =>
      FeedCommentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FeedCommentModel(feedCommentId: $feedCommentId, feedId: $feedId, author_id: $authorId, content: $content, create_at: $createAt, update_at: $updateAt)';
  }
}
