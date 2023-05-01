
import 'package:flutter_dowith/utils/convert_data.dart';

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

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'user_id': userId,
      'role': role,
      'latest_access': dataFormatter.format(latestAccess),
      'name': name,
      'contact': contact,
      'introduce': introduce,
      'image_url': imageUrl,
    };
  }

  factory MembersListModel.fromJson(Map<String, dynamic> json) {
    return MembersListModel(
      userId: json['user_id'] as int,
      role: json['role'] as int,
      latestAccess: DateTime.parse(json['latest_access']),
      name: json['name'] as String,
      contact: json['contact'] != null ? json['contact'] as String : null,
      introduce: json['introduce'] != null ? json['introduce'] as String : null,
      imageUrl: json['image_url'] != null ? json['image_url'] as String : null,
    );
  }
}
