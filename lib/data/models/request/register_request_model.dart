import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class RegisterRequestModel {
  final String name;
  final String email;
  final String username;
  final String phone;
  final String password;
  RegisterRequestModel({
    required this.name,
    required this.email,
    required this.username,
    required this.phone,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'username': username,
      'phone': phone,
      'password': password,
    };
  }

  factory RegisterRequestModel.fromMap(Map<String, dynamic> map) {
    return RegisterRequestModel(
      name: map['name'] as String,
      email: map['email'] as String,
      username: map['username'] as String,
      phone: map['phone'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterRequestModel.fromJson(String source) =>
      RegisterRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
