import 'package:flutter/cupertino.dart';

class UserData {
  final String name, email, password;

  UserData({required this.name, required this.email, required this.password});

  Map<String, dynamic> toMap() =>
      {'name': name, 'email': email, 'password': password};

  factory UserData.fromMap(Map<String, dynamic> map) => UserData(
      name: map['name'], email: map['email'], password: map['password']);
}