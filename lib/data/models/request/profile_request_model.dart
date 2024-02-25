import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProfileRequestModel {
  final String? name;
  final String? email;
  final String? username;
  final String? phone;
  ProfileRequestModel({
    this.name,
    this.email,
    this.username,
    this.phone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'username': username,
      'phone': phone,
    };
  }

  factory ProfileRequestModel.fromMap(Map<String, dynamic> map) {
    return ProfileRequestModel(
      name: map['name'] != null ? map['name'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileRequestModel.fromJson(String source) =>
      ProfileRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
