import 'dart:convert';

class ProfileResponseModel {
  int? id;
  String? name;
  String? email;
  String? username;
  String? phone;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProfileResponseModel({
    this.id,
    this.name,
    this.email,
    this.username,
    this.phone,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory ProfileResponseModel.fromJson(String str) =>
      ProfileResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProfileResponseModel.fromMap(Map<String, dynamic> json) =>
      ProfileResponseModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        username: json["username"],
        phone: json["phone"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "username": username,
        "phone": phone,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
