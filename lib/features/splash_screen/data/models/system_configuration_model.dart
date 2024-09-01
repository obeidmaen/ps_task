// To parse this JSON data, do
//
//     final systemConfigurationModel = systemConfigurationModelFromJson(jsonString);

import 'dart:convert';

SystemConfigurationModel systemConfigurationModelFromJson(str) =>
    SystemConfigurationModel.fromJson(str);

String systemConfigurationModelToJson(SystemConfigurationModel data) =>
    json.encode(data.toJson());

class SystemConfigurationModel {
  String? ageErrorMessageAr;
  String? ageErrorMessageEn;
  String? ageRegex;
  String? countryCode;
  String? fullNameErrorMessageAr;
  String? fullNameErrorMessageEn;
  String? fullNameRegex;
  String? incorrectPasswordAr;
  String? incorrectPasswordEn;
  String? confirmPasswordErrorMessageAr;
  String? confirmPasswordErrorMessageEn;
  String? passwordErrorMessageAr;
  String? passwordErrorMessageEn;
  String? passwordRegex;
  String? phoneErrorMessageAr;
  String? phoneErrorMessageEn;
  String? phoneRegex;

  SystemConfigurationModel({
    this.ageErrorMessageAr,
    this.ageErrorMessageEn,
    this.ageRegex,
    this.countryCode,
    this.fullNameErrorMessageAr,
    this.fullNameErrorMessageEn,
    this.fullNameRegex,
    this.incorrectPasswordAr,
    this.incorrectPasswordEn,
    this.confirmPasswordErrorMessageAr,
    this.confirmPasswordErrorMessageEn,
    this.passwordErrorMessageAr,
    this.passwordErrorMessageEn,
    this.passwordRegex,
    this.phoneErrorMessageAr,
    this.phoneErrorMessageEn,
    this.phoneRegex,
  });

  factory SystemConfigurationModel.fromJson(Map<String, dynamic> json) =>
      SystemConfigurationModel(
        ageErrorMessageAr: json["ageErrorMessageAr"],
        ageErrorMessageEn: json["ageErrorMessageEn"],
        ageRegex: json["ageRegex"],
        countryCode: json["countryCode"],
        fullNameErrorMessageAr: json["fullNameErrorMessageAr"],
        fullNameErrorMessageEn: json["fullNameErrorMessageEn"],
        fullNameRegex: json["fullNameRegex"],
        incorrectPasswordAr: json["incorrectPasswordAr"],
        incorrectPasswordEn: json["incorrectPasswordEn"],
        confirmPasswordErrorMessageAr: json["confirmPasswordErrorMessageAr"],
        confirmPasswordErrorMessageEn: json["confirmPasswordErrorMessageEn"],
        passwordErrorMessageAr: json["passwordErrorMessageAr"],
        passwordErrorMessageEn: json["passwordErrorMessageEn"],
        passwordRegex: json["passwordRegex"],
        phoneErrorMessageAr: json["phoneErrorMessageAr"],
        phoneErrorMessageEn: json["phoneErrorMessageEn"],
        phoneRegex: json["phoneRegex"],
      );

  Map<String, dynamic> toJson() => {
        "ageErrorMessageAr": ageErrorMessageAr,
        "ageErrorMessageEn": ageErrorMessageEn,
        "ageRegex": ageRegex,
        "countryCode": countryCode,
        "fullNameErrorMessageAr": fullNameErrorMessageAr,
        "fullNameErrorMessageEn": fullNameErrorMessageEn,
        "fullNameRegex": fullNameRegex,
        "incorrectPasswordAr": incorrectPasswordAr,
        "incorrectPasswordEn": incorrectPasswordEn,
        "confirmPasswordErrorMessageAr": confirmPasswordErrorMessageAr,
        "confirmPasswordErrorMessageEn": confirmPasswordErrorMessageEn,
        "passwordErrorMessageAr": passwordErrorMessageAr,
        "passwordErrorMessageEn": passwordErrorMessageEn,
        "passwordRegex": passwordRegex,
        "phoneErrorMessageAr": phoneErrorMessageAr,
        "phoneErrorMessageEn": phoneErrorMessageEn,
        "phoneRegex": phoneRegex,
      };
}
