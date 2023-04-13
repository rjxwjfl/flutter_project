// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  int? userId;
  String username;
  String? userPw;
  String deviceToken;
  String fbUid;

  UserModel({this.userId, required this.username, this.userPw, required this.deviceToken, required this.fbUid});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': userId,
      'username': username,
      'user_pw': userPw,
      'device_token': deviceToken,
      'fb_uid': fbUid
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        userId: map['user_id'] != null ? map['user_id'] as int : null,
        username: map['username'] as String,
        userPw: map['user_pw'] != null ? map['user_pw'] as String : null,
        deviceToken: map['device_token'] as String,
        fbUid: map['fb_uid'] as String);
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
