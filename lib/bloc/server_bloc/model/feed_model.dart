// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// Feed Model
class FeedModel {
  int? feedId;
  int projectId;
  int authorId;
  String title;
  String content;
  DateTime createAt;
  DateTime updateAt;
  FeedModel({
    this.feedId,
    required this.projectId,
    required this.authorId,
    required this.title,
    required this.content,
    required this.createAt,
    required this.updateAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'feed_id': feedId,
      'project_id': projectId,
      'author_id': authorId,
      'title': title,
      'content': content,
      'create_at': createAt.millisecondsSinceEpoch,
      'update_at': updateAt.millisecondsSinceEpoch,
    };
  }

  factory FeedModel.fromMap(Map<String, dynamic> map) {
    return FeedModel(
      feedId: map['feed_id'] != null ? map['feed_id'] as int : null,
      projectId: map['project_id'] as int,
      authorId: map['author_id'] as int,
      title: map['title'] as String,
      content: map['content'] as String,
      createAt: DateTime.fromMillisecondsSinceEpoch(map['create_at'] as int),
      updateAt: DateTime.fromMillisecondsSinceEpoch(map['update_at'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory FeedModel.fromJson(String source) =>
      FeedModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FeedModel(feed_id: $feedId, project_id: $projectId, author_id: $authorId, title: $title, content: $content, create_at: $createAt, update_at: $updateAt)';
  }
}


// Feed Comment Model
class FeedCommentModel {
  int? fcommentId;
  int feedId;
  String content;
  DateTime createAt;
  DateTime updateAt;
  FeedCommentModel({
    this.fcommentId,
    required this.feedId,
    required this.content,
    required this.createAt,
    required this.updateAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fcomment_id': fcommentId,
      'feed_id': feedId,
      'content': content,
      'create_at': createAt.millisecondsSinceEpoch,
      'update_at': updateAt.millisecondsSinceEpoch,
    };
  }

  factory FeedCommentModel.fromMap(Map<String, dynamic> map) {
    return FeedCommentModel(
      fcommentId: map['fcomment_id'] != null ? map['fcomment_id'] as int : null,
      feedId: map['feed_id'] as int,
      content: map['content'] as String,
      createAt: DateTime.fromMillisecondsSinceEpoch(map['create_at'] as int),
      updateAt: DateTime.fromMillisecondsSinceEpoch(map['update_at'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory FeedCommentModel.fromJson(String source) => FeedCommentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FeedCommentModel(fcomment_id: $fcommentId, feed_id: $feedId, content: $content, create_at: $createAt, update_at: $updateAt)';
  }
}
