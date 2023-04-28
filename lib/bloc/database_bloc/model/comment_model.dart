// Feed Comment Model
import 'package:flutter_dowith/utils/convert_data.dart';

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
}
