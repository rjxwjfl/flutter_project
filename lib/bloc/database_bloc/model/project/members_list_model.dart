// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:intl/intl.dart';

class MembersListModel {
  int userId;
  int role;
  DateTime latestAccess;
  String name;
  String? contact;
  String? introduce;
  String? imageUrl;

  MembersListModel({
    required this.userId,
    required this.role,
    required this.latestAccess,
    required this.name,
    this.contact,
    this.introduce,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return <String, dynamic>{
      'user_id': userId,
      'role': role,
      'latest_access': formatter.format(latestAccess),
      'name': name,
      'contact': contact,
      'introduce': introduce,
      'image_url': imageUrl,
    };
  }

  factory MembersListModel.fromMap(Map<String, dynamic> map) {
    return MembersListModel(
      userId: map['user_id'] as int,
      role: map['role'] as int,
      latestAccess: DateTime.parse(map['latest_access']),
      name: map['name'] as String,
      contact: map['contact'] != null ? map['contact'] as String : null,
      introduce: map['introduce'] != null ? map['introduce'] as String : null,
      imageUrl: map['image_url'] != null ? map['image_url'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MembersListModel.fromJson(String source) =>
      MembersListModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
