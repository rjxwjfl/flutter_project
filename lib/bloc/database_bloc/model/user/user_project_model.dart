// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserProjectModel {
  int? userPrjId;
  int userId;
  int prjId;
  UserProjectModel({
    this.userPrjId,
    required this.userId,
    required this.prjId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_prj_id': userPrjId,
      'user_id': userId,
      'prj_id': prjId,
    };
  }

  factory UserProjectModel.fromMap(Map<String, dynamic> map) {
    return UserProjectModel(
      userPrjId: map['user_prj_id'] != null ? map['user_prj_id'] as int : null,
      userId: map['user_id'] as int,
      prjId: map['prj_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProjectModel.fromJson(String source) => UserProjectModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserProjectModel(user_prj_id: $userPrjId, user_id: $userId, prj_id: $prjId)';
}
