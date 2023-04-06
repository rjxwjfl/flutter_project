import 'dart:convert';

// User Model

class UserModel {
  int? userId;
  String username;
  String? password;
  String deviceToken;
  String fbUid;
  UserModel({
    this.userId,
    required this.username,
    this.password,
    required this.deviceToken,
    required this.fbUid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': userId,
      'username': username,
      'password': password,
      'device_token': deviceToken,
      'fb_uid': fbUid,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['user_id'] != null ? map['user_id'] as int : null,
      username: map['username'] as String,
      password: map['password'] != null ? map['password'] as String : null,
      deviceToken: map['device_token'] as String,
      fbUid: map['fb_uid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(user_id: $userId, username: $username, password: $password, device_token: $deviceToken, fb_uid: $fbUid)';
  }
}

// User Detail Model

class UserDetailModel {
  int? userDtlId;
  int userId;
  DateTime createAt;
  DateTime updateAt;
  DateTime latestAccess;
  String name;
  String? introduce;
  String? imageUrl;
  bool state;
  DateTime subscriptionDeadline;
  UserDetailModel({
    this.userDtlId,
    required this.userId,
    required this.createAt,
    required this.updateAt,
    required this.latestAccess,
    required this.name,
    this.introduce,
    this.imageUrl,
    required this.state,
    required this.subscriptionDeadline,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_dtl_id': userDtlId,
      'user_id': userId,
      'create_at': createAt.millisecondsSinceEpoch,
      'update_at': updateAt.millisecondsSinceEpoch,
      'latest_access': latestAccess.millisecondsSinceEpoch,
      'name': name,
      'introduce': introduce,
      'image_url': imageUrl,
      'state': state,
      'subscription_deadline': subscriptionDeadline.millisecondsSinceEpoch,
    };
  }

  factory UserDetailModel.fromMap(Map<String, dynamic> map) {
    return UserDetailModel(
      userDtlId:
          map['user_dtl_id'] != null ? map['user_dtl_id'] as int : null,
      userId: map['user_id'] as int,
      createAt: DateTime.fromMillisecondsSinceEpoch(map['create_at'] as int),
      updateAt: DateTime.fromMillisecondsSinceEpoch(map['update_at'] as int),
      latestAccess:
          DateTime.fromMillisecondsSinceEpoch(map['latest_access'] as int),
      name: map['name'] as String,
      introduce: map['introduce'] != null ? map['introduce'] as String : null,
      imageUrl: map['image_url'] != null ? map['image_url'] as String : null,
      state: map['state'] as bool,
      subscriptionDeadline: DateTime.fromMillisecondsSinceEpoch(
          map['subscription_deadline'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDetailModel.fromJson(String source) =>
      UserDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserDetailModel(user_dtl_id: $userDtlId, user_id: $userId, create_at: $createAt, update_at: $updateAt, latest_access: $latestAccess, name: $name, introduce: $introduce, image_url: $imageUrl, state: $state, subscription_deadline: $subscriptionDeadline)';
  }
}

// User Project

class UserProject {
  int? userProjectId;
  int userId;
  int projectId;
  UserProject({
    this.userProjectId,
    required this.userId,
    required this.projectId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_project_id': userProjectId,
      'user_id': userId,
      'project_id': projectId,
    };
  }

  factory UserProject.fromMap(Map<String, dynamic> map) {
    return UserProject(
      userProjectId:
          map['user_project_id'] != null ? map['user_project_id'] as int : null,
      userId: map['user_id'] as int,
      projectId: map['project_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProject.fromJson(String source) =>
      UserProject.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UserProject(user_project_id: $userProjectId, user_id: $userId, project_id: $projectId)';
}

// Payment Info

class PaymentInfo {
  int? paymentId;
  int userId;
  DateTime date;
  PaymentInfo({
    this.paymentId,
    required this.userId,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'payment_id': paymentId,
      'user_id': userId,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory PaymentInfo.fromMap(Map<String, dynamic> map) {
    return PaymentInfo(
      paymentId: map['payment_id'] != null ? map['payment_id'] as int : null,
      userId: map['user_id'] as int,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentInfo.fromJson(String source) => PaymentInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PaymentInfo(payment_id: $paymentId, user_id: $userId, date: $date)';
}
