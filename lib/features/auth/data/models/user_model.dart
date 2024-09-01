// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(str) => UserModel.fromJson(str);

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? id;
  String? phoneNumber;
  String? hashedPassword;
  String? fullName;
  String? age;
  int? gender;

  UserModel({
    this.id,
    this.phoneNumber,
    this.hashedPassword,
    this.fullName,
    this.age,
    this.gender,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        phoneNumber: json["phoneNumber"],
        hashedPassword: json["hashedPassword"],
        fullName: json["fullName"],
        age: json["age"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "phoneNumber": phoneNumber,
        "hashedPassword": hashedPassword,
        "fullName": fullName,
        "age": age,
        "gender": gender,
      };
}

class Gender {
  int id;
  String text;

  Gender({required this.id, required this.text});
}
