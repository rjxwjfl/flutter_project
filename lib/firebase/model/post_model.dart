// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:uuid/uuid.dart';

class PostModel {
  String id;
  String title;
  String content;
  String author;
  DateTime createAt;
  DateTime startOn;
  DateTime expireOn;

  PostModel({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.createAt,
    required this.startOn,
    required this.expireOn,
  });

  PostModel copyWith({
    String? id,
    String? title,
    String? content,
    String? author,
    DateTime? createAt,
    DateTime? startOn,
    DateTime? expireOn,
  }) {
    return PostModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      author: author ?? this.author,
      createAt: createAt ?? this.createAt,
      startOn: startOn ?? this.startOn,
      expireOn: expireOn ?? this.expireOn,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'author': author,
      'createAt': createAt.millisecondsSinceEpoch,
      'startOn': startOn.millisecondsSinceEpoch,
      'expireOn': expireOn.millisecondsSinceEpoch,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      author: map['author'] as String,
      createAt: DateTime.fromMillisecondsSinceEpoch(map['createAt'] as int),
      startOn: DateTime.fromMillisecondsSinceEpoch(map['startOn'] as int),
      expireOn: DateTime.fromMillisecondsSinceEpoch(map['expireOn'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PostModel(id: $id, title: $title, content: $content, author: $author, createAt: $createAt, startOn: $startOn, expireOn: $expireOn)';
  }

  @override
  bool operator ==(covariant PostModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.content == content &&
        other.author == author &&
        other.createAt == createAt &&
        other.startOn == startOn &&
        other.expireOn == expireOn;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        content.hashCode ^
        author.hashCode ^
        createAt.hashCode ^
        startOn.hashCode ^
        expireOn.hashCode;
  }

  String generateUuid(){
    var uuid = const Uuid().v4();
    String genUuid = uuid.replaceAll('-', '');
    return genUuid;
  }
}
