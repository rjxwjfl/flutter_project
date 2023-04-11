// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:intl/intl.dart';

// Feed Model
class FeedModel {
  int? feedId;
  int prjId;
  int authorId;
  String title;
  String feedCnt;
  DateTime createAt;
  DateTime updateAt;
  FeedModel({
    this.feedId,
    required this.prjId,
    required this.authorId,
    required this.title,
    required this.feedCnt,
    required this.createAt,
    required this.updateAt,
  });

  Map<String, dynamic> toMap() {
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return <String, dynamic>{
      'feed_id': feedId,
      'prj_id': prjId,
      'author_id': authorId,
      'title': title,
      'feed_cnt': feedCnt,
      'create_at': formatter.format(createAt),
      'update_at': formatter.format(updateAt),
    };
  }

  factory FeedModel.fromMap(Map<String, dynamic> map) {
    return FeedModel(
      feedId: map['feed_id'] != null ? map['feed_id'] as int : null,
      prjId: map['prj_id'] as int,
      authorId: map['author_id'] as int,
      title: map['title'] as String,
      feedCnt: map['feed_cnt'] as String,
      createAt: DateTime.parse(map['create_at']),
      updateAt: DateTime.parse(map['update_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory FeedModel.fromJson(String source) =>
      FeedModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FeedModel(feed_id: $feedId, project_id: $prjId, author_id: $authorId, title: $title, content: $feedCnt, create_at: $createAt, update_at: $updateAt)';
  }
}
