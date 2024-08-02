// To parse this JSON data, do
//
//     final blogCategoriesModel = blogCategoriesModelFromJson(jsonString);

import 'dart:convert';

List<BlogCategoriesModel> blogCategoriesModelFromJson(String str) =>
    List<BlogCategoriesModel>.from(
        json.decode(str).map((x) => BlogCategoriesModel.fromJson(x)));

String blogCategoriesModelToJson(List<BlogCategoriesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BlogCategoriesModel {
  int? id;
  String? name;

  BlogCategoriesModel({
    this.id,
    this.name,
  });

  factory BlogCategoriesModel.fromJson(Map<String, dynamic> json) =>
      BlogCategoriesModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
