class UserCompactModel {
  String name;
  String imageUrl;
  UserCompactModel({
    required this.name,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'image_url': imageUrl,
    };
  }

  factory UserCompactModel.fromJson(Map<String, dynamic> json) {
    return UserCompactModel(
      name: json['name'] as String,
      imageUrl: json['image_url'] as String,
    );
  }
}