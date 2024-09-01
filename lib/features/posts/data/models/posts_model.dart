// To parse this JSON data, do
//
//     final postsModel = postsModelFromJson(jsonString);

import 'dart:convert';

List<PostsModel> postsModelFromJson(str) =>
    List<PostsModel>.from(str.map((x) => PostsModel.fromJson(x)));

String postsModelToJson(List<PostsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostsModel {
  int? userId;
  int? id;
  String? title;
  String? body;

  PostsModel({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  factory PostsModel.fromJson(Map<String, dynamic> json) => PostsModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}
