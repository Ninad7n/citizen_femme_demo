// To parse this JSON data, do
//
//     final blogListModel = blogListModelFromJson(jsonString);

import 'dart:convert';

List<BlogListModel> blogListModelFromJson(String str) =>
    List<BlogListModel>.from(
        json.decode(str).map((x) => BlogListModel.fromJson(x)));

String blogListModelToJson(List<BlogListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BlogListModel {
  int? id;
  String? title;
  String? featuredImage;
  String? shortContent;

  BlogListModel({
    this.id,
    this.title,
    this.featuredImage,
    this.shortContent,
  });

  factory BlogListModel.fromJson(Map<String, dynamic> json) => BlogListModel(
        id: json["id"],
        title: json["title"],
        featuredImage: json["featured_image"],
        shortContent: json["short_content"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "featured_image": featuredImage,
        "short_content": shortContent,
      };
}
