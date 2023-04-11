// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:intl/intl.dart';

class UserDtlModel {
  int? userDtlId;
  int userId;
  DateTime createAt;
  DateTime updateAt;
  DateTime latestAccess;
  String name;
  String? contact;
  String? introduce;
  String? imageUrl;
  bool subState;
  DateTime? subDeadLine;
  UserDtlModel({
    this.userDtlId,
    required this.userId,
    required this.createAt,
    required this.updateAt,
    required this.latestAccess,
    required this.name,
    this.contact,
    this.introduce,
    this.imageUrl,
    required this.subState,
    this.subDeadLine,
  });

  Map<String, dynamic> toMap() {
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return <String, dynamic>{
      'user_dtl_id': userDtlId,
      'user_id': userId,
      'create_at': formatter.format(createAt),
      'update_at': formatter.format(updateAt),
      'latest_access': formatter.format(latestAccess),
      'name': name,
      'contact': contact,
      'introduce': introduce,
      'image_url': imageUrl,
      'sub_state': subState,
      'sub_deadLine': formatter.format(subDeadLine!),
    };
  }

  factory UserDtlModel.fromMap(Map<String, dynamic> map) {
    return UserDtlModel(
      userDtlId: map['user_dtl_id'] != null ? map['user_dtl_id'] as int : null,
      userId: map['user_id'] as int,
      createAt: DateTime.parse(map['create_at']),
      updateAt: DateTime.parse(map['update_at']),
      latestAccess: DateTime.parse(map['latest_access']),
      name: map['name'] as String,
      contact: map['contact'] != null ? map['contact'] as String : null,
      introduce: map['introduce'] != null ? map['introduce'] as String : null,
      imageUrl: map['image_url'] != null ? map['image_url'] as String : null,
      subState: map['sub_state'] as bool,
      subDeadLine: map['sub_deadLine'] != null ? DateTime.parse(map['sub_deadLine']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDtlModel.fromJson(String source) => UserDtlModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserDtlModel(user_dtl_id: $userDtlId, user_id: $userId, create_at: $createAt, update_at: $updateAt, latest_access: $latestAccess, name: $name, contact: $contact, introduce: $introduce, image_url: $imageUrl, sub_state: $subState, sub_deadLine: $subDeadLine)';
  }
}
